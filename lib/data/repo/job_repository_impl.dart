import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/safe_api_call.dart';
import 'package:jobify_project/core/enums/application_status.dart';
import 'package:jobify_project/data/data_source/job_remote_data_source.dart';
import 'package:jobify_project/data/mappers/job_mapper.dart';
import 'package:jobify_project/domain/entities/create_job_request_entity.dart';
import 'package:jobify_project/domain/entities/create_job_response_entity.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/domain/entities/get_all_jobs_response_entity.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/domain/entities/get_job_by_id_response_entity.dart';

import 'package:jobify_project/domain/entities/job_application_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';
import 'package:jobify_project/data/mappers/job_application_mapper.dart';

@Injectable(as: JobRepository)
class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource _remoteDataSource;

  JobRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<CreateJobResponseEntity>> createJob(CreateJobRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.createJob(request.toModel()),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<List<JobEntity>>> getMyJobs() async {
    return await safeApiCall(
      () => _remoteDataSource.getMyJobs(),
      (response) => response.jobs?.map((job) => job.toEntity()).toList() ?? const [],
    );
  }

  @override
  Future<ApiResult<CreateJobResponseEntity>> updateJob(String id, Map<String, dynamic> request) async {
    return await safeApiCall(
      () => _remoteDataSource.updateJob(id, request),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<CreateJobResponseEntity>> deleteJob(String id) async {
    return await safeApiCall(
      () => _remoteDataSource.deleteJob(id),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<List<JobApplicationEntity>>> getJobApplications(String jobId) async {
    return await safeApiCall(
      () => _remoteDataSource.getJobApplications(jobId),
      (response) => response.applications?.map((app) => app.toEntity()).toList() ?? const [],
    );
  }

  @override
  Future<ApiResult<List<JobApplicationEntity>>> updateApplicationStatus(String id, ApplicationStatus status) async {
    return await safeApiCall(
      () => _remoteDataSource.updateApplicationStatus(id, {
        "status": status.name,
      }),
      (response) => response.applications?.map((app) => app.toEntity()).toList() ?? const [],
    );
  }

  @override
  Future<ApiResult<GetAllJobsResponseEntity>> getAllJobs(GetAllJobsRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.getAllJobs(request),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<GetJobByIdResponseEntity>> getJobById(String id) async {
    return await safeApiCall(
      () => _remoteDataSource.getJobById(id),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<List<JobEntity>>> getSavedJobs() async {
    return await safeApiCall(
      () => _remoteDataSource.getSavedJobs(),
      (response) => response.jobs?.map((job) => job.toEntity()).toList() ?? const [],
    );
  }

  @override
  Future<ApiResult<String>> saveJob(String id) async {
    return await safeApiCall(
      () => _remoteDataSource.saveJob(id),
      (response) => response.message ?? 'Success',
    );
  }

  @override
  Future<ApiResult<String>> removeSavedJob(String id) async {
    return await safeApiCall(
      () => _remoteDataSource.removeSavedJob(id),
      (response) => response.message ?? 'Success',
    );
  }
}
