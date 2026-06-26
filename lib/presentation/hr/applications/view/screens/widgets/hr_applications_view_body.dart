import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_application_card.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/widgets/custom_search_bar.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/hr/applications/view_model/hr_applications_cubit.dart';
import 'package:jobify_project/presentation/hr/applications/view_model/hr_applications_event.dart';
import 'package:jobify_project/presentation/hr/applications/view_model/hr_applications_state.dart';

class HrApplicationsViewBody extends StatelessWidget {
  const HrApplicationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Column(
      children: [
        CustomAppBar(title: local.incomingApplications, showBackButton: false),
        const SizedBox(height: AppMeasurements.paddingMedium),
        CustomSearchBar(
          hintText: " Search..",
          onChanged: (value) {
            context.read<HrApplicationsCubit>().doIntent(
              SearchHrApplicationsEvent(value),
            );
          },
        ),
        Expanded(
          child: BlocBuilder<HrApplicationsCubit, HrApplicationsState>(
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

              if (state.filteredJobs.isEmpty && state.searchQuery.isNotEmpty) {
                return Center(
                  child: Text(
                    "No applications found for '${state.searchQuery}'",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }

              if (state.filteredJobs.isEmpty) {
                return Center(
                  child: Text(
                    "No jobs posted yet",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }

              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: state.filteredJobs.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppMeasurements.paddingSmall),
                itemBuilder: (context, index) {
                  final job = state.filteredJobs[index];
                  return CustomJobApplicationCard(
                    jobTitle: job.title,
                    companyName: job.companyName,
                    salary: job.salary,
                    location: job.location,
                    logoUrl: job.logoAsset,
                    status: ApplicationStatus.onTheWay,
                    onViewApplication: () {
                      context.push(
                        RouteNames.hrJobApplications,
                        extra: {'jobId': job.id, 'jobTitle': job.title},
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
