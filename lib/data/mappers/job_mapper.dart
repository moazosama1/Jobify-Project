import 'package:jobify_project/api/models/create_job_response.dart';
import 'package:jobify_project/api/models/requests/company_snapshot_model.dart';
import 'package:jobify_project/api/models/requests/create_job_request_model.dart';
import 'package:jobify_project/api/models/requests/salary_range_model.dart';
import 'package:jobify_project/api/models/job_dto.dart';
import 'package:jobify_project/domain/entities/company_snapshot_entity.dart';
import 'package:jobify_project/domain/entities/create_job_request_entity.dart';
import 'package:jobify_project/domain/entities/create_job_response_entity.dart';
import 'package:jobify_project/domain/entities/salary_range_entity.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

extension CompanySnapshotEntityMapper on CompanySnapshotEntity {
  CompanySnapshotModel toModel() {
    return CompanySnapshotModel(
      name: name,
      logo: logo,
    );
  }
}

extension SalaryRangeEntityMapper on SalaryRangeEntity {
  SalaryRangeModel toModel() {
    return SalaryRangeModel(
      min: min,
      max: max,
    );
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
    return CreateJobResponseEntity(
      message: message ?? '',
    );
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

    return JobEntity(
      id: id ?? mongoId ?? "",
      companyName: companySnapshot?.name ?? "",
      logoAsset: companySnapshot?.logo ?? "",
      title: title ?? "",
      salary: salaryStr,
      tags: tagsList,
      location: location ?? "",
      isBookmarked: false,
    );
  }
}
