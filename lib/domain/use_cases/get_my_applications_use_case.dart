import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/get_my_applications_response_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class GetMyApplicationsUseCase {
  final JobRepository _repo;

  GetMyApplicationsUseCase(this._repo);

  Future<ApiResult<GetMyApplicationsResponseEntity>> call({
    int? page,
    int? limit,
    String? status,
  }) async {
    return await _repo.getMyApplications(
      page: page,
      limit: limit,
      status: status,
    );
  }
}
