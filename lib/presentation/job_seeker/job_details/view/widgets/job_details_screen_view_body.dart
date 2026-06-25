import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/widgets/suggested_job_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view/widgets/job_details_requirements_section.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view_model/job_details_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view_model/job_details_event.dart';

class JobDetailsScreenViewBody extends StatelessWidget {
  const JobDetailsScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<JobDetailsCubit>().state;
    final jobState = state.jobDetails;
    final job = jobState.data;

    if (job == null || jobState.isLoading) {
      return const CustomLoadingIndicator();
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SuggestedJobCard(
              job: job,
              width: double.infinity,
              onBookmarkTap: () {
                context.read<JobDetailsCubit>().doIntent(
                  ToggleSavedJobDetailsEvent(job.id),
                );
              },
              onApplyTap: () {
                context.push(RouteNames.applyJob, extra: job.id);
              },
            ),
          ),

          const SizedBox(height: AppMeasurements.paddingLarge),
          JobDetailsRequirementsSection(
            description: job.description,
            requirements: job.requirements,
            skillsRequired: job.skillsRequired,
            responsibilities: job.responsibilities,
            category: job.category,
            employmentType: job.employmentType,
            experienceLevel: job.experienceLevel,
            applicationDeadline: job.applicationDeadline,
            location: job.location,
            salary: job.salary,
            onApplyPressed: () {
              context.push(RouteNames.applyJob, extra: job.id);
            },
          ),
        ],
      ),
    );
  }
}
