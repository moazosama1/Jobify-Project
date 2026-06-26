import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/get_all_jobs_response_entity.dart';
import 'package:jobify_project/domain/use_cases/get_recent_searches_usecase.dart';
import 'package:jobify_project/domain/use_cases/save_recent_search_usecase.dart';
import 'package:jobify_project/domain/use_cases/clear_recent_searches_usecase.dart';
import 'package:jobify_project/domain/use_cases/get_all_jobs_use_case.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/presentation/search/view_model/search_event.dart';
import 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final GetRecentSearchesUseCase _getRecentSearchesUseCase;
  final SaveRecentSearchUseCase _saveRecentSearchUseCase;
  final ClearRecentSearchesUseCase _clearRecentSearchesUseCase;
  final GetAllJobsUseCase _getAllJobsUseCase;

  final TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;

  SearchCubit(
    this._getRecentSearchesUseCase,
    this._saveRecentSearchUseCase,
    this._clearRecentSearchesUseCase,
    this._getAllJobsUseCase,
  ) : super(const SearchState()) {
    _init();
  }

  void _init() {
    doIntent(LoadRecentSearchesSearchEvent());
  }

  void doIntent(SearchEvent event) {
    if (event is LoadRecentSearchesSearchEvent) {
      _loadRecentSearches();
    } else if (event is SubmitSearchEvent) {
      _submitSearch(event.query);
    } else if (event is ClearRecentSearchesSearchEvent) {
      _clearRecentSearches();
    } else if (event is QueryChangedSearchEvent) {
      _onQueryChanged(event.query);
    } else if (event is ClearResultsSearchEvent) {
      _clearSearchResults();
    } else if (event is UpdateFiltersSearchEvent) {
      _onUpdateFilters(event.filters);
    }
  }

  Future<void> _loadRecentSearches() async {
    emit(state.copyWith(recentSearches: const BaseState(isLoading: true)));
    final result = await _getRecentSearchesUseCase();
    if (result is ApiSuccessResult<List<String>>) {
      emit(state.copyWith(recentSearches: BaseState(data: result.data)));
    } else if (result is ApiErrorResult) {
      emit(
        state.copyWith(
          recentSearches: BaseState(
            errorMessage: (result as ApiErrorResult).errorMessage,
          ),
        ),
      );
    }
  }

  Future<void> _submitSearch(String query) async {
    if (query.trim().isEmpty && !state.hasActiveFilters) {
      _clearSearchResults();
      return;
    }

    emit(
      state.copyWith(
        hasSearched: true,
        searchResults: const BaseState(isLoading: true),
      ),
    );

    // Save recent search if not empty
    if (query.trim().isNotEmpty) {
      await _saveRecentSearchUseCase(query.trim());
      await _loadRecentSearches();
    }

    // Merge search query with active filters
    final request = state.activeFilters != null
        ? GetAllJobsRequestEntity(
            search: query.trim(),
            location: state.activeFilters!.location,
            employmentType: state.activeFilters!.employmentType,
            experienceLevel: state.activeFilters!.experienceLevel,
            category: state.activeFilters!.category,
            isRemote: state.activeFilters!.isRemote,
            minSalary: state.activeFilters!.minSalary,
            maxSalary: state.activeFilters!.maxSalary,
          )
        : GetAllJobsRequestEntity(search: query.trim());

    final result = await _getAllJobsUseCase(request);
    switch (result) {
      case ApiSuccessResult():
        emit(state.copyWith(searchResults: BaseState(data: result.data.jobs)));
      
      case ApiErrorResult<GetAllJobsResponseEntity>():
        emit(
          state.copyWith(
            searchResults: BaseState(
              errorMessage: (result.errorMessage ),
            ),
          ),
        );
    }
  }

  Future<void> _clearRecentSearches() async {
    final result = await _clearRecentSearchesUseCase();
    if (result is ApiSuccessResult<bool> && result.data) {
      await _loadRecentSearches();
    }
  }

  void _onQueryChanged(String query) {
    if (query.trim().isEmpty && !state.hasActiveFilters) {
      _debounceTimer?.cancel();
      if (state.hasSearched) {
        _clearSearchResults();
      }
      return;
    }

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      doIntent(SubmitSearchEvent(query));
    });
  }

  void _clearSearchResults() {
    emit(state.copyWith(hasSearched: false, searchResults: const BaseState()));
  }

  void _onUpdateFilters(GetAllJobsRequestEntity filters) {
    emit(state.copyWith(activeFilters: filters));
    if (searchController.text.isNotEmpty) {
      doIntent(SubmitSearchEvent(searchController.text));
    } else {
      doIntent(SubmitSearchEvent(""));
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    searchController.dispose();
    return super.close();
  }
}
