import 'package:jobify_project/api/models/create_job_response.dart';
import 'package:jobify_project/api/models/requests/create_job_request_model.dart';
import 'package:jobify_project/api/models/get_my_jobs_response.dart';

abstract interface class JobRemoteDataSource {
  Future<CreateJobResponse> createJob(CreateJobRequestModel request);
  Future<GetMyJobsResponse> getMyJobs();
}
