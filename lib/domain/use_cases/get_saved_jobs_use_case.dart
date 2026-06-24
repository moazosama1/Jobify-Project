import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class GetSavedJobsUseCase {
  final JobRepository _repository;

  GetSavedJobsUseCase(this._repository);

  Future<ApiResult<List<JobEntity>>> call() {
    return _repository.getSavedJobs();
  }
}
