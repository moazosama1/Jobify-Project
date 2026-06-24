import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'hr_profile_contact_info_widget.dart';
import 'hr_profile_header_widget.dart';
import 'hr_profile_resume_widget.dart';
import 'hr_profile_stats_widget.dart';
import '../../view_model/hr_profile_cubit.dart';
import '../../view_model/hr_profile_event.dart';
import '../../view_model/hr_profile_state.dart';
import 'package:toastification/toastification.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/router/route_names.dart';

class HrProfileScreenViewBody extends StatelessWidget {
  const HrProfileScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    return BlocConsumer<HrProfileCubit, HrProfileState>(
      listenWhen: (previous, current) =>
          previous.logoutSuccess != current.logoutSuccess ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.logoutSuccess) {
          customToastification(
            context,
            ToastificationType.success,
            local.success,
          );
          context.go(RouteNames.login);
        } else if (state.errorMessage != null && !state.isLoading) {
          customToastification(
            context,
            ToastificationType.error,
            state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.errorMessage != null && state.name.isEmpty) {
          return Center(
            child: Text(
              state.errorMessage!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section (Avatar, Name, Title)
              HrProfileHeaderWidget(
                name: state.name,
                title: state.title,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // Stats section (Applied, Reviewed, Interview counts)
              HrProfileStatsWidget(
                appliedCount: state.appliedCount,
                reviewedCount: state.reviewedCount,
                interviewCount: state.interviewCount,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // Resume section (CV, PDF preview)
              HrProfileResumeWidget(
                name: state.name,
                title: state.title,
                description: state.description,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // Contact Info section (Name, Email, Phone Number fields)
              HrProfileContactInfoWidget(
                name: state.name,
                email: state.email,
                phoneNumber: state.phoneNumber,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // Logout Button
              CustomElevatedButtonLoading(
                isLoading: state.isLogoutLoading,
                textButton: 'Logout', // Hardcoded string as fallback
                colorButton: theme.colorScheme.error,
                onPressed: () {
                  context.read<HrProfileCubit>().doIntent(const HrProfileLogoutEvent());
                },
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),
            ],
          ),
        );
      },
    );
  }
}