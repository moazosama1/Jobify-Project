import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/search/view/widgets/search_body.dart';
import 'package:jobify_project/presentation/search/view_model/search_cubit.dart';
import 'package:jobify_project/presentation/search/view_model/search_event.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<SearchCubit>()..doIntent(LoadRecentSearchesEvent()),
      child: CustomScreenWrapper(
        appBar: CustomAppBar(
          title: AppLocalizations.of(context).searchJob,
          showBackButton: true,
        ),
        body: const SearchBody(),
      ),
    );
  }
}
