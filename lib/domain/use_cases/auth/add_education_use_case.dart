import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/entities/education_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class AddEducationUseCase {
  final AuthRepo _authRepo;

  const AddEducationUseCase(this._authRepo);

  Future<ApiResult<UserEntity>> call(EducationRequestEntity params) async {
    return await _authRepo.addEducation(params);
  }
}
