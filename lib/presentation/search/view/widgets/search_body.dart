import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/search/view_model/search_cubit.dart';
import 'package:jobify_project/presentation/search/view_model/search_event.dart';

import 'recent_searches_section.dart';
import 'browse_category_section.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppMeasurements.paddingLarge),
        CustomTextField(
          controller: cubit.searchController,
          hintText: AppLocalizations.of(context).searchPlaceholder,
          prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
          textInputAction: TextInputAction.search,
          onSubmitted: (query) {
            cubit.doIntent(SearchSubmittedEvent(query));
          },
        ),
        const SizedBox(height: AppMeasurements.paddingExtraLarge),
        const RecentSearchesSection(),
        const SizedBox(height: AppMeasurements.paddingMedium),
        const BrowseCategorySection(),
        const SizedBox(height: AppMeasurements.paddingExtraLarge),
      ],
    );
  }
}
