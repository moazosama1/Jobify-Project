import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';

sealed class SearchEvent {}

class LoadRecentSearchesEvent extends SearchEvent {}

class SearchQueryChangedEvent extends SearchEvent {
  final String query;
  SearchQueryChangedEvent(this.query);
}

class SearchSubmittedEvent extends SearchEvent {
  final String query;
  SearchSubmittedEvent(this.query);
}

class ClearRecentSearchesEvent extends SearchEvent {}

class ClearSearchResultsEvent extends SearchEvent {}

class UpdateSearchFiltersEvent extends SearchEvent {
  final GetAllJobsRequestEntity filters;
  UpdateSearchFiltersEvent(this.filters);
}
