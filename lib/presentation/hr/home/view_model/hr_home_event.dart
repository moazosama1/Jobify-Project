sealed class HrHomeEvent {}

class HrHomeLoadDataEvent extends HrHomeEvent {}

class HrHomeToggleBookmarkEvent extends HrHomeEvent {
  final String jobId;
  HrHomeToggleBookmarkEvent(this.jobId);
}

class HrHomeDeleteJobEvent extends HrHomeEvent {
  final String jobId;
  HrHomeDeleteJobEvent(this.jobId);
}
