import 'package:equatable/equatable.dart';
import 'package:jobify_project/domain/entities/my_job_application_entity.dart';

class ApplyJobResponseEntity extends Equatable {
  final String message;
  final MyJobApplicationEntity? application;

  const ApplyJobResponseEntity({
    required this.message,
    this.application,
  });

  @override
  List<Object?> get props => [message, application];
}
