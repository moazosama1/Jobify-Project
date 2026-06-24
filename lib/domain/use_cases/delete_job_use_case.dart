import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/create_job_response_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class DeleteJobUseCase {
  final JobRepository _repository;

  DeleteJobUseCase(this._repository);

  Future<ApiResult<CreateJobResponseEntity>> call(String id) async {
    return await _repository.deleteJob(id);
  }
}
