import 'package:equatable/equatable.dart';
import 'application_user_entity.dart';

class JobApplicationEntity extends Equatable {
  final String id;
  final String jobId;
  final String jobTitle;
  final ApplicationUserEntity user;
  final String status;
  final String resume;
  final String coverLetter;
  final String createdAt;

  const JobApplicationEntity({
    required this.id,
    required this.jobId,
    this.jobTitle = '',
    required this.user,
    required this.status,
    required this.resume,
    required this.coverLetter,
    required this.createdAt,
  });

  JobApplicationEntity copyWith({
    String? id,
    String? jobId,
    String? jobTitle,
    ApplicationUserEntity? user,
    String? status,
    String? resume,
    String? coverLetter,
    String? createdAt,
  }) {
    return JobApplicationEntity(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      jobTitle: jobTitle ?? this.jobTitle,
      user: user ?? this.user,
      status: status ?? this.status,
      resume: resume ?? this.resume,
      coverLetter: coverLetter ?? this.coverLetter,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, jobId, jobTitle, user, status, resume, coverLetter, createdAt];
}
