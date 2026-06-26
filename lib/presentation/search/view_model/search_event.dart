import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';

sealed class SearchEvent {}

class LoadRecentSearchesSearchEvent extends SearchEvent {}

class QueryChangedSearchEvent extends SearchEvent {
  final String query;
  QueryChangedSearchEvent(this.query);
}

class SubmitSearchEvent extends SearchEvent {
  final String query;
  SubmitSearchEvent(this.query);
}

class ClearRecentSearchesSearchEvent extends SearchEvent {}

class ClearResultsSearchEvent extends SearchEvent {}

class UpdateFiltersSearchEvent extends SearchEvent {
  final GetAllJobsRequestEntity filters;
  UpdateFiltersSearchEvent(this.filters);
}
