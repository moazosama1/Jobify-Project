import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/reset_password_entity.dart';
import 'package:jobify_project/domain/entities/reset_password_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _repo;

  ResetPasswordUseCase(this._repo);

  Future<ApiResult<ResetPasswordEntity>> call(ResetPasswordRequestEntity request) async {
    return await _repo.resetPassword(request);
  }
}
