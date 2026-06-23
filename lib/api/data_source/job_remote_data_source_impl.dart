import 'package:injectable/injectable.dart';
import 'package:jobify_project/api/client/api_client.dart';
import 'package:jobify_project/api/models/create_job_response.dart';
import 'package:jobify_project/api/models/requests/create_job_request_model.dart';
import 'package:jobify_project/api/models/get_my_jobs_response.dart';
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
  Future<GetMyJobsResponse> getMyJobs() {
    return _apiClient.getMyJobs();
  }
}
