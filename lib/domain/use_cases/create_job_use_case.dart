import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import '../entities/create_job_request_entity.dart';
import '../entities/create_job_response_entity.dart';
import '../repo/job_repository.dart';

@injectable
class CreateJobUseCase {
  final JobRepository _repository;

  CreateJobUseCase(this._repository);

  Future<ApiResult<CreateJobResponseEntity>> call(CreateJobRequestEntity request) async {
    return await _repository.createJob(request);
  }
}
