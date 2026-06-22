import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/use_cases/get_recent_searches_usecase.dart';
import 'package:jobify_project/domain/use_cases/save_recent_search_usecase.dart';
import 'package:jobify_project/domain/use_cases/clear_recent_searches_usecase.dart';
import 'package:jobify_project/presentation/search/view_model/search_event.dart';
import 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final GetRecentSearchesUseCase _getRecentSearchesUseCase;
  final SaveRecentSearchUseCase _saveRecentSearchUseCase;
  final ClearRecentSearchesUseCase _clearRecentSearchesUseCase;

  final TextEditingController searchController = TextEditingController();

  SearchCubit(
    this._getRecentSearchesUseCase,
    this._saveRecentSearchUseCase,
    this._clearRecentSearchesUseCase,
  ) : super(const SearchState());

  void doIntent(SearchEvent event) {
    if (event is LoadRecentSearchesEvent) {
      _loadRecentSearches();
    } else if (event is SearchSubmittedEvent) {
      _submitSearch(event.query);
    } else if (event is ClearRecentSearchesEvent) {
      _clearRecentSearches();
    } else if (event is SearchQueryChangedEvent) {
      // Intentional blank for live filter logic later.
    }
  }

  Future<void> _loadRecentSearches() async {
    final result = await _getRecentSearchesUseCase();
    if (result is ApiSuccessResult<List<String>>) {
      emit(state.copyWith(recentSearches: result.data));
    } else if (result is ApiErrorResult) {
      // handle error gracefully if needed
    }
  }

  Future<void> _submitSearch(String query) async {
    if (query.trim().isEmpty) return;

    final result = await _saveRecentSearchUseCase(query.trim());
    if (result is ApiSuccessResult<bool> && result.data) {
      await _loadRecentSearches();
    }
  }

  Future<void> _clearRecentSearches() async {
    final result = await _clearRecentSearchesUseCase();
    if (result is ApiSuccessResult<bool> && result.data) {
      await _loadRecentSearches();
    }
  }
}
