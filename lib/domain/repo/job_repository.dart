import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/enums/application_status.dart';
import '../entities/create_job_request_entity.dart';
import '../entities/create_job_response_entity.dart';
import '../entities/job_entity.dart';
import '../entities/job_application_entity.dart';

abstract interface class JobRepository {
  Future<ApiResult<CreateJobResponseEntity>> createJob(CreateJobRequestEntity request);
  Future<ApiResult<List<JobEntity>>> getMyJobs();
  Future<ApiResult<CreateJobResponseEntity>> updateJob(String id, Map<String, dynamic> request);
  Future<ApiResult<CreateJobResponseEntity>> deleteJob(String id);
  Future<ApiResult<List<JobApplicationEntity>>> getJobApplications(String jobId);
  Future<ApiResult<List<JobApplicationEntity>>> updateApplicationStatus(String id, ApplicationStatus status);
}
