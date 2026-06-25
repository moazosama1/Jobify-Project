import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:toastification/toastification.dart';
import '../../view_model/edit_job_seeker_profile_cubit.dart';
import '../../view_model/edit_job_seeker_profile_state.dart';

import 'edit_basic_info_section.dart';
import 'edit_experience_section.dart';
import 'edit_education_section.dart';
import 'edit_skills_section.dart';
import 'edit_resume_section.dart';

class EditJobSeekerProfileBody extends StatelessWidget {
  const EditJobSeekerProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return BlocConsumer<EditJobSeekerProfileCubit, EditJobSeekerProfileState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          customToastification(
            context,
            ToastificationType.error,
            state.errorMessage,
          );
        } else if (state.successMessage != null) {
          customToastification(
            context,
            ToastificationType.success,
            state.successMessage,
          );
        }
      },
      builder: (context, state) {
        if (state.data == null && state.isLoading) {
          return const Center(child: CustomLoadingIndicator());
        }

        if (state.data == null && state.errorMessage != null) {
          return _buildErrorState(context, state.errorMessage!);
        }

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingMedium,
            vertical: AppMeasurements.paddingSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Profile Header Card ──
              _buildProfileHeader(context, state),
              const SizedBox(height: AppMeasurements.paddingMedium),

              // ── Section Label ──
              _buildSectionLabel(
                context,
                Icons.person_outline,
                local.personalInformation,
              ),
              const SizedBox(height: AppMeasurements.paddingSmall),
              const EditBasicInfoSection(),

              const SizedBox(height: AppMeasurements.paddingLarge),
              _buildSectionLabel(
                context,
                Icons.business_center_outlined,
                local.experience,
              ),
              const SizedBox(height: AppMeasurements.paddingSmall),
              const EditExperienceSection(),

              const SizedBox(height: AppMeasurements.paddingLarge),
              _buildSectionLabel(
                context,
                Icons.school_outlined,
                local.education,
              ),
              const SizedBox(height: AppMeasurements.paddingSmall),
              const EditEducationSection(),

              const SizedBox(height: AppMeasurements.paddingLarge),
              _buildSectionLabel(
                context,
                Icons.psychology_outlined,
                local.skills,
              ),
              const SizedBox(height: AppMeasurements.paddingSmall),
              const EditSkillsSection(),

              const SizedBox(height: AppMeasurements.paddingLarge),
              _buildSectionLabel(
                context,
                Icons.description_outlined,
                local.resume,
              ),
              const SizedBox(height: AppMeasurements.paddingSmall),
              const EditResumeSection(),

              const SizedBox(height: AppMeasurements.paddingExtraLarge * 2),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    EditJobSeekerProfileState state,
  ) {
    final user = state.data;
    if (user == null) return const SizedBox.shrink();

    final fullName = '${user.firstName} ${user.lastName}'.trim();
    final initials =
        '${user.firstName.isNotEmpty ? user.firstName[0] : ''}${user.lastName.isNotEmpty ? user.lastName[0] : ''}'
            .toUpperCase();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppMeasurements.paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.primaryColor,
            context.primaryColor.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppMeasurements.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Avatar ──
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                initials,
                style: context.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppMeasurements.paddingMedium),
          // ── Info ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: context.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: context.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user.role.toUpperCase(),
                    style: context.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: context.primaryColor, size: 22),
        const SizedBox(width: AppMeasurements.paddingSmall),
        Text(
          label,
          style: context.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.onSurfaceColor,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppMeasurements.paddingExtraLarge),
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
              message,
              style: context.bodyLarge?.copyWith(
                color: context.onSurfaceColor.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
