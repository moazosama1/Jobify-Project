import 'package:jobify_project/api/models/get_job_applications_response.dart';
import 'package:jobify_project/domain/entities/application_user_entity.dart';
import 'package:jobify_project/domain/entities/job_application_entity.dart';

extension ApplicationUserDtoMapper on ApplicationUserDto {
  ApplicationUserEntity toEntity() {
    return ApplicationUserEntity(
      id: id ?? '',
      firstName: (firstName == null || firstName!.isEmpty) ? 'Applicant' : firstName!,
      lastName: lastName ?? '',
      email: (email == null || email!.isEmpty) ? 'No email' : email!,
      profileImage: profileImage,
    );
  }
}

extension JobApplicationDtoMapper on JobApplicationDto {
  JobApplicationEntity toEntity() {
    String parsedJobId = '';
    String parsedJobTitle = '';
    if (jobId is String) {
      parsedJobId = jobId as String;
    } else if (jobId is Map) {
      parsedJobId = jobId['_id'] as String? ?? '';
      parsedJobTitle = jobId['title'] as String? ?? '';
    }

    return JobApplicationEntity(
      id: id ?? '',
      jobId: parsedJobId,
      jobTitle: parsedJobTitle,
      user: userId?.toEntity() ?? const ApplicationUserEntity(id: '', firstName: '', lastName: '', email: ''),
      status: status ?? 'pending',
      resume: resume ?? '',
      coverLetter: coverLetter ?? '',
      createdAt: createdAt ?? '',
    );
  }
}
