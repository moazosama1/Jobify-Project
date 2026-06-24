import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/enums/application_status.dart';
import '../entities/create_job_request_entity.dart';
import '../entities/create_job_response_entity.dart';
import '../entities/job_entity.dart';
import '../entities/job_application_entity.dart';

import 'package:jobify_project/domain/entities/get_all_jobs_response_entity.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/domain/entities/get_job_by_id_response_entity.dart';

abstract interface class JobRepository {
  Future<ApiResult<CreateJobResponseEntity>> createJob(CreateJobRequestEntity request);
  Future<ApiResult<List<JobEntity>>> getMyJobs();
  Future<ApiResult<CreateJobResponseEntity>> updateJob(String id, Map<String, dynamic> request);
  Future<ApiResult<CreateJobResponseEntity>> deleteJob(String id);
  Future<ApiResult<List<JobApplicationEntity>>> getJobApplications(String jobId);
  Future<ApiResult<List<JobApplicationEntity>>> updateApplicationStatus(String id, ApplicationStatus status);
  Future<ApiResult<GetAllJobsResponseEntity>> getAllJobs(GetAllJobsRequestEntity request);
  Future<ApiResult<GetJobByIdResponseEntity>> getJobById(String id);
  Future<ApiResult<List<JobEntity>>> getSavedJobs();
  Future<ApiResult<String>> saveJob(String id);
  Future<ApiResult<String>> removeSavedJob(String id);
}
