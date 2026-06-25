import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/search/view_model/search_cubit.dart';
import 'package:jobify_project/presentation/search/view_model/search_event.dart';
import 'package:jobify_project/presentation/search/view_model/search_state.dart';
import 'package:jobify_project/presentation/search/view/widgets/search_results_section.dart';
import 'package:jobify_project/presentation/search/view/widgets/search_filter_bottom_sheet.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';

import 'recent_searches_section.dart';
import 'browse_category_section.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    final theme = Theme.of(context);
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppMeasurements.paddingLarge),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: cubit.searchController,
                    hintText: AppLocalizations.of(context).searchPlaceholder,
                    prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
                    textInputAction: TextInputAction.search,
                    onChanged: (query) {
                      cubit.doIntent(SearchQueryChangedEvent(query));
                    },
                    onSubmitted: (query) {
                      cubit.doIntent(SearchSubmittedEvent(query));
                    },
                  ),
                ),
                const SizedBox(width: AppMeasurements.paddingMedium),
                Container(
                  decoration: BoxDecoration(
                    color: state.hasActiveFilters
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: state.hasActiveFilters
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.tune,
                      color: state.hasActiveFilters
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (bottomSheetContext) => SearchFilterBottomSheet(
                          initialFilters: state.activeFilters,
                          onApply: (filters) {
                            cubit.doIntent(UpdateSearchFiltersEvent(filters));
                          },
                          onClear: () {
                            cubit.doIntent(UpdateSearchFiltersEvent(const GetAllJobsRequestEntity()));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),
            if (state.hasSearched) ...[
              const Expanded(child: SearchResultsSection()),
            ] else ...[
              const Expanded(child: RecentSearchesSection()),
              const SizedBox(height: AppMeasurements.paddingMedium),
              const BrowseCategorySection(),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),
            ],
          ],
        );
      },
    );
  }
}
