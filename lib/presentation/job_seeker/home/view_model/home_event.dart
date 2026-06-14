sealed class HomeEvent {}

class HomeLoadDataEvent extends HomeEvent {}

class HomeToggleBookmarkEvent extends HomeEvent {
  final String jobId;
  HomeToggleBookmarkEvent(this.jobId);
}
