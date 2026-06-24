import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/enums/application_status.dart';
import 'package:jobify_project/domain/entities/job_application_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class UpdateApplicationStatusUseCase {
  final JobRepository _repository;

  UpdateApplicationStatusUseCase(this._repository);

  Future<ApiResult<List<JobApplicationEntity>>> call(String id, ApplicationStatus status) async {
    return await _repository.updateApplicationStatus(id, status);
  }
}
