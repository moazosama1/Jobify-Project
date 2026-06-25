import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/entities/update_skills_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class UpdateSkillsUseCase {
  final AuthRepo _authRepo;

  const UpdateSkillsUseCase(this._authRepo);

  Future<ApiResult<UserEntity>> call(UpdateSkillsRequestEntity params) async {
    return await _authRepo.updateSkills(params);
  }
}
