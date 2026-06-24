import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/widgets/custom_search_bar.dart';
import 'package:jobify_project/core/widgets/job_card.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view_model/saved_jobs_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view_model/saved_jobs_event.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view_model/saved_jobs_state.dart';
import 'package:jobify_project/generated/l10n.dart';

class SavedJobsViewBody extends StatelessWidget {
  const SavedJobsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedJobsCubit, SavedJobsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: AppLocalizations.of(context).savedJobsTitle),
            const SizedBox(height: AppMeasurements.paddingLarge),
            CustomSearchBar(
              hintText: AppLocalizations.of(context).searchPlaceholder,
              onChanged: (value) {
                context.read<SavedJobsCubit>().doIntent(
                  SavedJobsSearchEvent(value),
                );
              },
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),
            Text(
              AppLocalizations.of(context).savedJobsCountTitle(state.filteredJobs.length.toString()),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppMeasurements.paddingSmall),
            Expanded(
              child: state.isLoading && state.filteredJobs.isEmpty
                  ? const Center(child: CustomLoadingIndicator())
                  : (state.errorMessage != null &&
                        state.errorMessage!.isNotEmpty)
                  ? Center(child: Text(state.errorMessage!))
                  : state.filteredJobs.isEmpty
                  ? Center(child: Text(AppLocalizations.of(context).noSavedJobsFound))
                  : ListView.builder(
                      itemCount: state.filteredJobs.length,
                      itemBuilder: (context, index) {
                        final job = state.filteredJobs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppMeasurements.paddingMedium,
                          ),
                          child: Slidable(
                            key: ValueKey(job.id),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    context.read<SavedJobsCubit>().doIntent(
                                      SavedJobsRemoveEvent(job.id),
                                    );
                                  },
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                  foregroundColor: Theme.of(context).colorScheme.onError,
                                  icon: Icons.delete_outline,
                                  label: AppLocalizations.of(context).deleteAction,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ],
                            ),
                            child: JobCard(
                              onTap: () {
                                context.push(RouteNames.jobDetails, extra: job);
                              },
                              job: job,
                              onOptionsTap: () {
                                context.read<SavedJobsCubit>().doIntent(
                                  SavedJobsRemoveEvent(job.id),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
