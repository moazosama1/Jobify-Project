import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/job_application_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class GetJobApplicationsUseCase {
  final JobRepository _repository;

  GetJobApplicationsUseCase(this._repository);

  Future<ApiResult<List<JobApplicationEntity>>> call(String jobId) async {
    return await _repository.getJobApplications(jobId);
  }
}
