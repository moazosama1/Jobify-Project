import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';

class SearchState extends Equatable {
  final BaseState<List<String>> recentSearches;
  final BaseState<List<JobEntity>> searchResults;
  final bool hasSearched;
  final GetAllJobsRequestEntity? activeFilters;

  const SearchState({
    this.recentSearches = const BaseState<List<String>>(),
    this.searchResults = const BaseState<List<JobEntity>>(),
    this.hasSearched = false,
    this.activeFilters,
  });

  bool get hasActiveFilters {
    if (activeFilters == null) return false;
    return activeFilters!.location != null ||
        activeFilters!.employmentType != null ||
        activeFilters!.isRemote != null ||
        activeFilters!.experienceLevel != null ||
        activeFilters!.category != null ||
        activeFilters!.minSalary != null ||
        activeFilters!.maxSalary != null;
  }

  SearchState copyWith({
    BaseState<List<String>>? recentSearches,
    BaseState<List<JobEntity>>? searchResults,
    bool? hasSearched,
    GetAllJobsRequestEntity? activeFilters,
  }) {
    return SearchState(
      recentSearches: recentSearches ?? this.recentSearches,
      searchResults: searchResults ?? this.searchResults,
      hasSearched: hasSearched ?? this.hasSearched,
      activeFilters: activeFilters ?? this.activeFilters,
    );
  }

  @override
  List<Object?> get props => [
        recentSearches,
        searchResults,
        hasSearched,
        activeFilters,
      ];
}
