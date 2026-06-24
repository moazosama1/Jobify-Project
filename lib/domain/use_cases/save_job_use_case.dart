import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class SaveJobUseCase {
  final JobRepository _repository;

  SaveJobUseCase(this._repository);

  Future<ApiResult<String>> call(String jobId) {
    return _repository.saveJob(jobId);
  }
}
