import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/apply_job_response_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class ApplyJobUseCase {
  final JobRepository _repo;

  ApplyJobUseCase(this._repo);

  Future<ApiResult<ApplyJobResponseEntity>> call({
    required String jobId,
    required String resumeFilePath,
    String? coverLetter,
  }) async {
    return await _repo.applyJob(
      jobId: jobId,
      resumeFilePath: resumeFilePath,
      coverLetter: coverLetter,
    );
  }
}
