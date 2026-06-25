import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/entities/education_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class UpdateEducationUseCase {
  final AuthRepo _authRepo;

  const UpdateEducationUseCase(this._authRepo);

  Future<ApiResult<UserEntity>> call(String id, EducationRequestEntity params) async {
    return await _authRepo.updateEducation(id, params);
  }
}
