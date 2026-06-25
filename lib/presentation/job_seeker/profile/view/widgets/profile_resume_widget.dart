import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/constants/end_points.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileResumeWidget extends StatelessWidget {
  final String name;
  final String title;
  final String description;
  final String? resumeUrl;

  const ProfileResumeWidget({
    super.key,
    required this.name,
    required this.title,
    required this.description,
    this.resumeUrl,
  });

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final isDark = context.theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  color: context.primaryColor,
                  size: 22,
                ),
                const SizedBox(width: AppMeasurements.paddingSmall),
                Text(
                  local.resume,
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.onSurfaceColor,
                  ),
                ),
              ],
            ),
            if (resumeUrl != null && resumeUrl!.isNotEmpty)
              TextButton(
                onPressed: () async {
                  final String fullUrl;
                  if (resumeUrl!.startsWith('http')) {
                    fullUrl = resumeUrl!;
                  } else {
                    fullUrl = "${EndPoints.awsBaseUrl}$resumeUrl";
                  }

                  final String encodedUrl = Uri.encodeFull(fullUrl).replaceAll(' ', '%20');
                  final String googleDocsUrl = "https://docs.google.com/gview?embedded=true&url=$encodedUrl";
                  
                  final Uri url = Uri.parse(googleDocsUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
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
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.open_in_new,
                      size: 16,
                      color: context.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "View Resume",
                      style: context.bodyMedium?.copyWith(
                        color: context.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        Container(
          padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
          decoration: BoxDecoration(
            color: isDark ? context.surfaceColor : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.onSurfaceColor.withValues(alpha: 0.05),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: context.theme.shadowColor.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppMeasurements.paddingSmall,
                      vertical: AppMeasurements.paddingExtraSmall,
                    ),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      local.cv,
                      style: context.labelMedium?.copyWith(
                        color: context.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppMeasurements.paddingSmall,
                      vertical: AppMeasurements.paddingExtraSmall,
                    ),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      local.pdf,
                      style: context.labelMedium?.copyWith(
                        color: context.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppMeasurements.paddingMedium),
              Center(
                child: Text(
                  name,
                  style: context.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.onSurfaceColor,
                  ),
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingExtraSmall),
              Center(
                child: Text(
                  title,
                  style: context.bodySmall?.copyWith(
                    color: context.onSurfaceColor.withValues(alpha: 0.5),
                  ),
                ),
              ),
              if (description.isNotEmpty) ...[
                const SizedBox(height: AppMeasurements.paddingMedium),
                Center(
                  child: Text(
                    description,
                    style: context.bodySmall?.copyWith(
                      color: context.onSurfaceColor.withValues(alpha: 0.6),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
