import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/get_job_by_id_response_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class GetJobByIdUseCase {
  final JobRepository _repo;

  GetJobByIdUseCase(this._repo);

  Future<ApiResult<GetJobByIdResponseEntity>> call(String id) async {
    return await _repo.getJobById(id);
  }
}
