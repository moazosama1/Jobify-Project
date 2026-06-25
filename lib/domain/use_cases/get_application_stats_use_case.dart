import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/application_stats_entity.dart';
import 'package:jobify_project/domain/repo/job_repository.dart';

@injectable
class GetApplicationStatsUseCase {
  final JobRepository _repo;

  GetApplicationStatsUseCase(this._repo);

  Future<ApiResult<ApplicationStatsEntity>> call() async {
    return await _repo.getApplicationStats();
  }
}
