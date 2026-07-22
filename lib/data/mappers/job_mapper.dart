import 'package:jobify_project/api/models/create_job_response.dart';
import 'package:jobify_project/api/models/requests/company_snapshot_model.dart';
import 'package:jobify_project/api/models/requests/create_job_request_model.dart';
import 'package:jobify_project/core/constants/end_points.dart';
import 'package:jobify_project/api/models/requests/salary_range_model.dart';
import 'package:jobify_project/api/models/job_dto.dart';
import 'package:jobify_project/domain/entities/company_snapshot_entity.dart';
import 'package:jobify_project/domain/entities/create_job_request_entity.dart';
import 'package:jobify_project/domain/entities/create_job_response_entity.dart';
import 'package:jobify_project/domain/entities/salary_range_entity.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/api/models/get_all_jobs_response.dart';
import 'package:jobify_project/api/models/pagination_model.dart';
import 'package:jobify_project/domain/entities/get_all_jobs_response_entity.dart';
import 'package:jobify_project/domain/entities/pagination_entity.dart';
import 'package:jobify_project/api/models/get_job_by_id_response.dart';
import 'package:jobify_project/domain/entities/get_job_by_id_response_entity.dart';

extension CompanySnapshotEntityMapper on CompanySnapshotEntity {
  CompanySnapshotModel toModel() {
    return CompanySnapshotModel(name: name, logo: logo);
  }
}

extension SalaryRangeEntityMapper on SalaryRangeEntity {
  SalaryRangeModel toModel() {
    return SalaryRangeModel(min: min, max: max);
  }
}

extension CreateJobRequestEntityMapper on CreateJobRequestEntity {
  CreateJobRequestModel toModel() {
    return CreateJobRequestModel(
      companySnapshot: companySnapshot.toModel(),
      title: title,
      description: description,
      responsibilities: responsibilities,
      requirements: requirements,
      preferredQualifications: preferredQualifications,
      location: location,
      employmentType: employmentType,
      experienceLevel: experienceLevel,
      salaryRange: salaryRange.toModel(),
      applicationDeadline: applicationDeadline,
      skillsRequired: skillsRequired,
      category: category,
      openings: openings,
      isRemote: isRemote,
    );
  }
}

extension CreateJobResponseMapper on CreateJobResponse {
  CreateJobResponseEntity toEntity() {
    return CreateJobResponseEntity(message: message ?? '');
  }
}

extension JobDtoMapper on JobDto {
  JobEntity toEntity() {
    final tagsList = <String>[];
    if (employmentType != null) {
      tagsList.add(employmentType!);
    }
    if (experienceLevel != null) {
      tagsList.add(experienceLevel!);
    }
    if (isRemote == true) {
      tagsList.add("Remote");
    }

    final salaryStr = (salaryRange != null)
        ? "\$${salaryRange!.min} - \$${salaryRange!.max}"
        : "";

    final logoPath = companySnapshot?.logo ?? "";
    final resolvedLogo = logoPath.isNotEmpty && !logoPath.startsWith('http')
        ? "${EndPoints.awsBaseUrl}$logoPath"
        : logoPath;

    return JobEntity(
      id: id ?? mongoId ?? "",
      companyName: companySnapshot?.name ?? "",
      logoAsset: resolvedLogo,
      title: title ?? "",
      salary: salaryStr,
      tags: tagsList,
      location: location ?? "",
      description: description ?? "",
      responsibilities: responsibilities ?? const [],
      requirements: requirements ?? const [],
      skillsRequired: skillsRequired ?? const [],
      category: category ?? "",
      employmentType: employmentType ?? "",
      experienceLevel: experienceLevel ?? "",
      applicationDeadline: applicationDeadline ?? "",
      isBookmarked: false,
     
      preferredQualifications: preferredQualifications ?? const [],
    
      salaryMin: salaryRange?.min ?? 0,
      salaryMax: salaryRange?.max ?? 0,
     
      openings: openings ?? 1,
      isRemote: isRemote ?? false,
      applicationsCount: applicationsCount ?? 0,
      createdAt: createdAt ?? "",
    );
  }
}

extension PaginationModelMapper on PaginationModel {
  PaginationEntity toEntity() {
    return PaginationEntity(
      currentPage: currentPage ?? 1,
      totalPages: totalPages ?? 1,
      totalCount: totalCount ?? 0,
      limit: limit ?? 10,
    );
  }
}

extension GetAllJobsResponseMapper on GetAllJobsResponse {
  GetAllJobsResponseEntity toEntity() {
    return GetAllJobsResponseEntity(
      message: message ?? '',
      pagination: pagination?.toEntity(),
      jobs: jobs?.map((jobDto) => jobDto.toEntity()).toList() ?? [],
    );
  }
}

extension GetJobByIdResponseMapper on GetJobByIdResponse {
  GetJobByIdResponseEntity toEntity() {
    return GetJobByIdResponseEntity(
      message: message ?? '',
      job: job?.toEntity(),
    );
  }
}
