import 'package:jobify_project/api/models/get_job_applications_response.dart';
import 'package:jobify_project/domain/entities/application_user_entity.dart';
import 'package:jobify_project/domain/entities/job_application_entity.dart';

extension ApplicationUserDtoMapper on ApplicationUserDto {
  ApplicationUserEntity toEntity() {
    return ApplicationUserEntity(
      id: id ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
    );
  }
}

extension JobApplicationDtoMapper on JobApplicationDto {
  JobApplicationEntity toEntity() {
    return JobApplicationEntity(
      id: id ?? '',
      jobId: jobId ?? '',
      user: userId?.toEntity() ?? const ApplicationUserEntity(id: '', firstName: '', lastName: '', email: ''),
      status: status ?? 'pending',
      resume: resume ?? '',
      coverLetter: coverLetter ?? '',
      createdAt: createdAt ?? '',
    );
  }
}
