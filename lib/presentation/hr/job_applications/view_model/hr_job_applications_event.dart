import 'package:jobify_project/core/enums/application_status.dart';

sealed class HrJobApplicationsEvent {
  const HrJobApplicationsEvent();
}

class LoadJobApplicationsEvent extends HrJobApplicationsEvent {
  final String jobId;
  const LoadJobApplicationsEvent(this.jobId);
}

class UpdateStatusJobApplicationsEvent extends HrJobApplicationsEvent {
  final String id;
  final ApplicationStatus status;
  const UpdateStatusJobApplicationsEvent({required this.id, required this.status});
}
