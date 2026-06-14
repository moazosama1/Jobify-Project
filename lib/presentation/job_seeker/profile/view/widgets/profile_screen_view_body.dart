import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_contact_info_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_header_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_resume_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_stats_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_state.dart';

class ProfileScreenViewBody extends StatelessWidget {
  const ProfileScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.errorMessage != null) {
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
        //  physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section (Avatar, Name, Title)
              ProfileHeaderWidget(
                name: state.name,
                title: state.title,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // Stats section (Applied, Reviewed, Interview counts)
              ProfileStatsWidget(
                appliedCount: state.appliedCount,
                reviewedCount: state.reviewedCount,
                interviewCount: state.interviewCount,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // Resume section (CV, PDF preview)
              ProfileResumeWidget(
                name: state.name,
                title: state.title,
                description: state.description,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),

              // Contact Info section (Name, Email, Phone Number fields)
              ProfileContactInfoWidget(
                name: state.name,
                email: state.email,
                phoneNumber: state.phoneNumber,
              ),
              const SizedBox(height: AppMeasurements.paddingLarge),
            ],
          ),
        );
      },
    );
  }
}