import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/enums/application_status.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/constants/end_points.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/core/widgets/custom_cached_network_image.dart';
import 'package:jobify_project/domain/entities/job_application_entity.dart';
import 'package:jobify_project/presentation/hr/job_applications/view_model/hr_job_applications_cubit.dart';
import 'package:jobify_project/presentation/hr/job_applications/view_model/hr_job_applications_state.dart';
import 'package:jobify_project/presentation/hr/job_applications/view_model/hr_job_applications_event.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class HrJobApplicationsViewBody extends StatelessWidget {
  final String jobTitle;
  final bool showBackButton;

  const HrJobApplicationsViewBody({
    super.key,
    required this.jobTitle,
    this.showBackButton = true,
  });

  Future<void> _openPdf(BuildContext context, String resumePath) async {
    // لو الـ Backend مراجع الـ URL كامل، هنستخدمه، لو مراجع الـ path بس هنمجده مع رابط الـ Bucket
    final String urlString = resumePath.startsWith('http')
        ? resumePath
        : (EndPoints.awsBaseUrl + resumePath);

    // عمل encode للمسافات والحروف الخاصة بشكل صحيح لضمان عمل الرابط
    final String encodedUrl = Uri.encodeFull(urlString).replaceAll(' ', '%20');

    // On Android, raw PDF URLs just download in the background.
    // Using Google Docs Viewer renders the PDF directly on the screen inside the browser.
    final String googleDocsUrl = "https://docs.google.com/gview?embedded=true&url=$encodedUrl";

    debugPrint("🔗 AWS S3 Link: $encodedUrl");
    debugPrint("🔗 Google Docs Viewer Link: $googleDocsUrl");

    try {
      final Uri url = Uri.parse(googleDocsUrl);

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to raw S3 URL if Google Docs Viewer cannot be launched
        final Uri rawUrl = Uri.parse(encodedUrl);
        if (await canLaunchUrl(rawUrl)) {
          await launchUrl(rawUrl, mode: LaunchMode.externalApplication);
        } else {
          if (context.mounted) {
            customToastification(
              context,
              ToastificationType.error,
              "Could not open resume link",
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        customToastification(
          context,
          ToastificationType.error,
          "Error opening resume: $e",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(title: jobTitle, showBackButton: showBackButton),
        const SizedBox(height: AppMeasurements.paddingMedium),
        Expanded(
          child: BlocBuilder<HrJobApplicationsCubit, HrJobApplicationsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CustomLoadingIndicator());
              }

              if (state.errorMessage != null) {
                return Center(
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                );
              }

              if (state.applications.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 64,
                        color: context.onSurfaceColor.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: AppMeasurements.paddingMedium),
                      Text(
                        "No applications submitted yet",
                        style: context.bodyMedium?.copyWith(
                          color: context.onSurfaceColor.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMeasurements.paddingMedium,
                  vertical: AppMeasurements.paddingSmall,
                ),
                itemCount: state.applications.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppMeasurements.paddingMedium),
                itemBuilder: (context, index) {
                  final application = state.applications[index];
                  final formattedDate = application.createdAt.length >= 10
                      ? application.createdAt.substring(0, 10)
                      : application.createdAt;

                  return _buildApplicationCard(
                    context,
                    application,
                    formattedDate,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildApplicationCard(
    BuildContext context,
    JobApplicationEntity application,
    String formattedDate,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color statusColor = Colors.orange;
    if (application.status == 'accepted' || application.status == 'approved') {
      statusColor = AppColors.green;
    } else if (application.status == 'rejected') {
      statusColor = AppColors.red;
    } else if (application.status == 'reviewed') {
      statusColor = AppColors.mainColor;
    }

    return Container(
      padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.onSurfaceColor.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        width: 48,
                        height: 48,
                        color: Colors.grey.shade200,
                        child: (application.user.profileImage != null &&
                                application.user.profileImage!.isNotEmpty)
                            ? CustomCachedNetworkImage(
                                imageUrl: EndPoints.awsBaseUrl +
                                    application.user.profileImage!,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.person_rounded,
                                color: context.onSurfaceColor
                                    .withValues(alpha: 0.4),
                                size: 28,
                              ),
                      ),
                    ),
                    const SizedBox(width: AppMeasurements.paddingMedium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${application.user.firstName} ${application.user.lastName}",
                            style: context.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            application.jobTitle.isNotEmpty ? application.jobTitle : jobTitle,
                            style: context.bodySmall?.copyWith(
                              color: context.onSurfaceColor.withValues(alpha: 0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              context.push(RouteNames.userProfile,
                                  extra: application.user.id);
                            },
                            child: Text(
                              "View Profile",
                              style: context.bodySmall?.copyWith(
                                color: context.primaryColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  application.status.toUpperCase(),
                  style: context.bodySmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppMeasurements.paddingMedium),
          if (application.coverLetter.isNotEmpty) ...[
            Text(
              "Cover Letter",
              style: context.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppMeasurements.paddingSmall + 4),
              decoration: BoxDecoration(
                color: isDark
                    ? theme.colorScheme.surface.withValues(alpha: 0.5)
                    : const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                application.coverLetter,
                style: context.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: context.onSurfaceColor.withValues(alpha: 0.8),
                ),
              ),
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Applied on: $formattedDate",
                style: context.bodySmall?.copyWith(
                  color: context.onSurfaceColor.withValues(alpha: 0.4),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _openPdf(context, application.resume);
                  if (application.status == 'pending') {
                    context.read<HrJobApplicationsCubit>().doIntent(
                      UpdateStatusHrJobApplicationsEvent(
                        id: application.id,
                        status: ApplicationStatus.reviewed,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.picture_as_pdf_rounded, size: 18),
                label: Text(context.l10n.viewCv),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          if (application.status == 'pending' ||
              application.status == 'reviewed') ...[
            const SizedBox(height: AppMeasurements.paddingSmall),
            const Divider(height: 1, thickness: 0.5),
            const SizedBox(height: AppMeasurements.paddingSmall),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<HrJobApplicationsCubit>().doIntent(
                        UpdateStatusHrJobApplicationsEvent(
                          id: application.id,
                          status: ApplicationStatus.rejected,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.red,
                      side: const BorderSide(color: AppColors.red),
                      padding: const EdgeInsets.symmetric(
                        vertical: AppMeasurements.paddingSmall,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(context.l10n.reject),
                  ),
                ),
                const SizedBox(width: AppMeasurements.paddingSmall),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<HrJobApplicationsCubit>().doIntent(
                        UpdateStatusHrJobApplicationsEvent(
                          id: application.id,
                          status: ApplicationStatus.accepted,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppMeasurements.paddingSmall,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(context.l10n.accept),
                  ),
                ),
              ],
            ),
          ] else if (application.status == 'accepted' ||
              application.status == 'approved') ...[
            const SizedBox(height: AppMeasurements.paddingSmall),
            const Divider(height: 1, thickness: 0.5),
            const SizedBox(height: AppMeasurements.paddingSmall),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push(
                    RouteNames.hrChatScreen,
                    extra: {
                      'receiverId': application.user.id,
                      'userName': '${application.user.firstName} ${application.user.lastName}',
                      'userAvatar': application.user.profileImage,
                    },
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                label: Text(context.l10n.contact),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppMeasurements.paddingSmall,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
