import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_contact_info_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_header_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_resume_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_stats_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_experience_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_education_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_personal_info_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_skills_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_event.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_state.dart';
import 'package:toastification/toastification.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/router/route_names.dart';

class ProfileScreenViewBody extends StatelessWidget {
  const ProfileScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          previous.logoutSuccess != current.logoutSuccess ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.logoutSuccess) {
          customToastification(
            context,
            ToastificationType.success,
            context.l10n.success,
          );
          context.go(RouteNames.login);
        } else if (state.errorMessage != null && !state.isLoading) {
          customToastification(
            context,
            ToastificationType.error,
            state.errorMessage!,
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CustomLoadingIndicator());
        }

        final user = state.data;

        if (state.errorMessage != null && user == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off_outlined,
                  size: 64,
                  color: context.onSurfaceColor.withValues(alpha: 0.3),
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                Text(
                  state.errorMessage!,
                  style: context.bodyLarge?.copyWith(
                    color: context.onSurfaceColor.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        final name = user != null ? '${user.firstName} ${user.lastName}' : '';
        final email = user?.email ?? '';
        final phoneNumber = user?.phoneNumber ?? '';
        final title = user?.role ?? '';
        final bio = user?.bio ?? '';
        final skillsString = user?.skills.join(', ') ?? '';

        return RefreshIndicator(
          color: context.primaryColor,
          backgroundColor: context.surfaceColor,
          onRefresh: () async {
            context.read<ProfileCubit>().doIntent(const LoadProfileEvent());
            await Future.delayed(const Duration(milliseconds: 800));
          },
          child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header (Avatar, Name, Role, Bio) ──
              ProfileHeaderWidget(name: name, title: title, bio: bio),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // ── Stats (Applied, Pending, Reviewed, Interview, Accepted, Rejected) ──
              ProfileStatsWidget(
                stats: state.stats,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // ── Resume (CV Preview) ──
              ProfileResumeWidget(
                name: name,
                title: title,
                description: skillsString.isNotEmpty
                    ? 'Skills: $skillsString'
                    : '',
                resumeUrl: user?.resume,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // ── Skills ──
              ProfileSkillsWidget(
                skills: user?.skills ?? const [],
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // ── Experience ──
              ProfileExperienceWidget(
                experienceList: user?.experience ?? const [],
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // ── Education ──
              ProfileEducationWidget(
                educationList: user?.education ?? const [],
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // ── Personal Info (Age, Gender, Location, Job Preferences) ──
              ProfilePersonalInfoWidget(
                age: user?.age ?? 0,
                gender: user?.gender ?? '',
                location: user?.location ?? '',
                jobPreferences: user?.jobTypePreferences ?? const [],
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // ── Contact Info (Name, Email, Phone) ──
              ProfileContactInfoWidget(
                name: name,
                email: email,
                phoneNumber: phoneNumber,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // ── Logout Button ──
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButtonLoading(
                    isLoading: state.isLogoutLoading,
                    widthButton: 120,
                    textButton: context.l10n.logout,
                    colorButton: context.errorColor,
                    onPressed: () {
                      context.read<ProfileCubit>().doIntent(
                        const LogoutProfileEvent(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),
            ],
          ),
        ));
      },
    );
  }
}
