import 'package:jobify_project/api/models/apply_job_response.dart';
import 'package:jobify_project/api/models/get_my_applications_response.dart';
import 'package:jobify_project/data/mappers/job_mapper.dart';
import 'package:jobify_project/domain/entities/apply_job_response_entity.dart';
import 'package:jobify_project/domain/entities/get_my_applications_response_entity.dart';
import 'package:jobify_project/domain/entities/my_job_application_entity.dart';

extension MyJobApplicationDtoMapper on MyJobApplicationDto {
  MyJobApplicationEntity toEntity() {
    return MyJobApplicationEntity(
      id: id ?? "",
      job: jobId?.toEntity(),
      userId: userId ?? "",
      status: status ?? "",
      resume: resume ?? "",
      coverLetter: coverLetter ?? "",
      createdAt: createdAt ?? "",
    );
  }
}

extension ApplyJobApplicationDtoMapper on ApplyJobApplicationDto {
  MyJobApplicationEntity toEntity() {
    return MyJobApplicationEntity(
      id: id ?? "",
      job: null,
      userId: userId ?? "",
      status: status ?? "",
      resume: resume ?? "",
      coverLetter: coverLetter ?? "",
      createdAt: createdAt ?? "",
    );
  }
}

extension GetMyApplicationsResponseMapper on GetMyApplicationsResponse {
  GetMyApplicationsResponseEntity toEntity() {
    return GetMyApplicationsResponseEntity(
      message: message ?? "",
      pagination: pagination?.toEntity(),
      applications: applications?.map((dto) => dto.toEntity()).toList() ?? [],
    );
  }
}

extension ApplyJobResponseMapper on ApplyJobResponse {
  ApplyJobResponseEntity toEntity() {
    return ApplyJobResponseEntity(
      message: message ?? "",
      application: application?.toEntity(),
    );
  }
}
