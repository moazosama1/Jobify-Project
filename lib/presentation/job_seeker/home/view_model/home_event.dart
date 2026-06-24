import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';

sealed class HomeEvent {}

class HomeLoadDataEvent extends HomeEvent {}

class HomeToggleBookmarkEvent extends HomeEvent {
  final String jobId;
  HomeToggleBookmarkEvent(this.jobId);
}

class HomeUpdateFiltersEvent extends HomeEvent {
  final GetAllJobsRequestEntity filters;
  HomeUpdateFiltersEvent(this.filters);
}
