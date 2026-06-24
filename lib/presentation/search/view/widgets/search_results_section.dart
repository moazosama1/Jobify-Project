import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/widgets/job_card.dart';
import 'package:jobify_project/core/widgets/custom_shimmer_loading.dart';
import 'package:jobify_project/presentation/search/view_model/search_cubit.dart';
import 'package:jobify_project/presentation/search/view_model/search_state.dart';
import 'package:jobify_project/generated/l10n.dart';

class SearchResultsSection extends StatelessWidget {
  const SearchResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.searchResults.isLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppMeasurements.paddingSmall,
            ),
            child: buildShimmerList(
              length: 5,
              height: 100, // Approximate height of JobCard
              borderItem: 20, // To match JobCard border radius
              separatorHeight: AppMeasurements.paddingMedium,
            ),
          );
        }

        if (state.searchResults.errorMessage != null) {
          return Center(
            child: Text(
              state.searchResults.errorMessage!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.red),
            ),
          );
        }

        final jobs = state.searchResults.data;

        if (jobs == null || jobs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 64,
                  color: AppColors.gray.withValues(alpha: 0.5),
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                Text(
                  AppLocalizations.of(context).notAvailable,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: AppColors.gray),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: jobs.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppMeasurements.paddingMedium),
          itemBuilder: (context, index) {
            final job = jobs[index];
            return JobCard(
              job: job,
              onTap: () {
                context.push(RouteNames.jobDetails, extra: job);
              },
            );
          },
        );
      },
    );
  }
}
