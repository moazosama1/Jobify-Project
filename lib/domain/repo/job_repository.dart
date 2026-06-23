import 'package:jobify_project/core/api_result/api_result.dart';
import '../entities/create_job_request_entity.dart';
import '../entities/create_job_response_entity.dart';
import '../entities/job_entity.dart';

abstract interface class JobRepository {
  Future<ApiResult<CreateJobResponseEntity>> createJob(CreateJobRequestEntity request);
  Future<ApiResult<List<JobEntity>>> getMyJobs();
}
