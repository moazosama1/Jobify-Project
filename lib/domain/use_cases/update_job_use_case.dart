import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/create_job_response_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class UpdateJobUseCase {
  final JobRepository _repository;

  UpdateJobUseCase(this._repository);

  Future<ApiResult<CreateJobResponseEntity>> call(String id, Map<String, dynamic> request) async {
    return await _repository.updateJob(id, request);
  }
}
