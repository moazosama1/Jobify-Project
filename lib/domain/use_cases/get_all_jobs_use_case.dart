import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/get_all_jobs_response_entity.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class GetAllJobsUseCase {
  final JobRepository _repo;

  GetAllJobsUseCase(this._repo);

  Future<ApiResult<GetAllJobsResponseEntity>> call([
    GetAllJobsRequestEntity? request,
  ]) async {
    return await _repo.getAllJobs(request ?? const GetAllJobsRequestEntity());
  }
}
