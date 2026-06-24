import 'package:equatable/equatable.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class GetJobByIdResponseEntity extends Equatable {
  final String message;
  final JobEntity? job;

  const GetJobByIdResponseEntity({
    required this.message,
    this.job,
  });

  @override
  List<Object?> get props => [message, job];
}
