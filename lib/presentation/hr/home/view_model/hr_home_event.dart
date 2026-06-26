sealed class HrHomeEvent {}

class LoadHrHomeEvent extends HrHomeEvent {}

class ToggleBookmarkHrHomeEvent extends HrHomeEvent {
  final String jobId;
  ToggleBookmarkHrHomeEvent(this.jobId);
}

class DeleteJobHrHomeEvent extends HrHomeEvent {
  final String jobId;
  DeleteJobHrHomeEvent(this.jobId);
}

class SearchHrHomeEvent extends HrHomeEvent {
  final String query;
  SearchHrHomeEvent(this.query);
}
