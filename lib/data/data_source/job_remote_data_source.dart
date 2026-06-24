import 'package:jobify_project/api/models/create_job_response.dart';
import 'package:jobify_project/api/models/requests/create_job_request_model.dart';
import 'package:jobify_project/api/models/get_my_jobs_response.dart';

import 'package:jobify_project/api/models/get_all_jobs_response.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/api/models/get_job_by_id_response.dart';
import 'package:jobify_project/api/models/get_saved_jobs_response.dart';
import 'package:jobify_project/api/models/toggle_saved_job_response.dart';

abstract interface class JobRemoteDataSource {
  Future<CreateJobResponse> createJob(CreateJobRequestModel request);
  Future<GetMyJobsResponse> getMyJobs();
  Future<GetAllJobsResponse> getAllJobs(GetAllJobsRequestEntity request);
  Future<GetJobByIdResponse> getJobById(String id);
  Future<GetSavedJobsResponse> getSavedJobs();
  Future<ToggleSavedJobResponse> saveJob(String id);
  Future<ToggleSavedJobResponse> removeSavedJob(String id);
}
