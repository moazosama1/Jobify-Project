import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/entities/experience_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class UpdateExperienceUseCase {
  final AuthRepo _authRepo;

  const UpdateExperienceUseCase(this._authRepo);

  Future<ApiResult<UserEntity>> call(String id, ExperienceRequestEntity params) async {
    return await _authRepo.updateExperience(id, params);
  }
}
