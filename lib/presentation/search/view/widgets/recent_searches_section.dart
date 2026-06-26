import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/search/view_model/search_cubit.dart';
import 'package:jobify_project/presentation/search/view_model/search_event.dart';
import 'package:jobify_project/presentation/search/view_model/search_state.dart';

class RecentSearchesSection extends StatelessWidget {
  const RecentSearchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              local.recentSearches,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state.recentSearches.data == null ||
                    state.recentSearches.data!.isEmpty) {
                  return const SizedBox.shrink();
                }
                return InkWell(
                  onTap: () {
                    context.read<SearchCubit>().doIntent(
                      ClearRecentSearchesSearchEvent(),
                    );
                  },
                  child: Icon(
                    Icons.clear_all,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        Expanded(child: _buildRecentSearchesList()),
      ],
    );
  }

  Widget _buildRecentSearchesList() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.recentSearches.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.recentSearches.errorMessage != null) {
          return Center(
            child: Text(
              state.recentSearches.errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                  ),
            ),
          );
        }

        final searches = state.recentSearches.data ?? const [];
        if (searches.isEmpty) {
          return const SizedBox.shrink();
        }

        return ListView.builder(
          itemCount: searches.length,
          itemBuilder: (context, index) {
            final query = searches[index];
            if (query.isEmpty) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.only(
                bottom: AppMeasurements.paddingSmall,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  final cubit = context.read<SearchCubit>();
                  cubit.searchController.text = query;
                  cubit.doIntent(SubmitSearchEvent(query));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: AppMeasurements.paddingMedium),
                      Expanded(
                        child: Text(
                          query,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_outward_rounded,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
