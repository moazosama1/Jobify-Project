sealed class JobDetailsEvent {}

class LoadJobDetailsEvent extends JobDetailsEvent {}

class ToggleSavedJobDetailsEvent extends JobDetailsEvent {
  final String jobId;
  ToggleSavedJobDetailsEvent(this.jobId);
}
