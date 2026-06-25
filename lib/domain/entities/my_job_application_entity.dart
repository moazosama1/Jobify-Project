import 'package:equatable/equatable.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class MyJobApplicationEntity extends Equatable {
  final String id;
  final JobEntity? job;
  final String userId;
  final String status;
  final String resume;
  final String coverLetter;
  final String createdAt;

  const MyJobApplicationEntity({
    required this.id,
    this.job,
    required this.userId,
    required this.status,
    required this.resume,
    required this.coverLetter,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, job, userId, status, resume, coverLetter, createdAt];
}
