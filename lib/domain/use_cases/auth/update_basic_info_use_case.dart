import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/entities/update_basic_info_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class UpdateBasicInfoUseCase {
  final AuthRepo _authRepo;

  const UpdateBasicInfoUseCase(this._authRepo);

  Future<ApiResult<UserEntity>> call(UpdateBasicInfoRequestEntity params) async {
    return await _authRepo.updateBasicInfo(params);
  }
}
