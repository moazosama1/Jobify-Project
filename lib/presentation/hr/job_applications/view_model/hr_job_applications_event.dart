import 'package:jobify_project/core/enums/application_status.dart';

sealed class HrJobApplicationsEvent {
  const HrJobApplicationsEvent();
}

class LoadHrJobApplicationsEvent extends HrJobApplicationsEvent {
  final String jobId;
  const LoadHrJobApplicationsEvent(this.jobId);
}

class UpdateStatusHrJobApplicationsEvent extends HrJobApplicationsEvent {
  final String id;
  final ApplicationStatus status;
  const UpdateStatusHrJobApplicationsEvent({required this.id, required this.status});
}
