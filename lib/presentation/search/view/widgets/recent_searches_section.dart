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

    return Expanded(
      child: Column(
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
                  if (state.recentSearches.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return InkWell(
                    onTap: () {
                      context.read<SearchCubit>().doIntent(
                        ClearRecentSearchesEvent(),
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
      ),
    );
  }

  Widget _buildRecentSearchesList() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.recentSearches.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: AppMeasurements.paddingSmall,
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.grey, size: 20),
                  const SizedBox(width: AppMeasurements.paddingMedium),
                  Text(
                    state.recentSearches[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
