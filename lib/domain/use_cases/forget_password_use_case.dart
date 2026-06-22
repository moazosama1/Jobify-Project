import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/forget_password_entity.dart';
import 'package:jobify_project/domain/entities/forget_password_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _repo;

  ForgetPasswordUseCase(this._repo);

  Future<ApiResult<ForgetPasswordEntity>> call(ForgetPasswordRequestEntity request) async {
    return await _repo.forgetPassword(request);
  }
}
