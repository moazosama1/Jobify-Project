import 'package:injectable/injectable.dart';
import 'package:jobify_project/api/client/api_client.dart';
import 'package:jobify_project/api/models/create_job_response.dart';
import 'package:jobify_project/api/models/requests/create_job_request_model.dart';
import 'package:jobify_project/api/models/get_my_jobs_response.dart';
import 'package:jobify_project/api/models/get_all_jobs_response.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/api/models/get_job_by_id_response.dart';
import 'package:jobify_project/api/models/get_saved_jobs_response.dart';
import 'package:jobify_project/api/models/toggle_saved_job_response.dart';
import 'package:jobify_project/data/data_source/job_remote_data_source.dart';

@Injectable(as: JobRemoteDataSource)
class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final ApiClient _apiClient;

  JobRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CreateJobResponse> createJob(CreateJobRequestModel request) {
    return _apiClient.createJob(request);
  }

  @override
  Future<GetMyJobsResponse> getMyJobs({int? page, int? limit}) {
    return _apiClient.getMyJobs(page, limit);
  }

  @override
  Future<GetAllJobsResponse> getAllJobs(GetAllJobsRequestEntity request) {
    return _apiClient.getAllJobs(request.toMap());
  }

  @override
  Future<GetJobByIdResponse> getJobById(String id) {
    return _apiClient.getJobById(id);
  }

  @override
  Future<GetSavedJobsResponse> getSavedJobs() {
    return _apiClient.getSavedJobs();
  }

  @override
  Future<ToggleSavedJobResponse> saveJob(String id) {
    return _apiClient.saveJob(id);
  }

  @override
  Future<ToggleSavedJobResponse> removeSavedJob(String id) {
    return _apiClient.removeSavedJob(id);
  }
}
