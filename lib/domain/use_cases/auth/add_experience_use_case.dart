import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/entities/experience_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class AddExperienceUseCase {
  final AuthRepo _authRepo;

  const AddExperienceUseCase(this._authRepo);

  Future<ApiResult<UserEntity>> call(ExperienceRequestEntity params) async {
    return await _authRepo.addExperience(params);
  }
}
