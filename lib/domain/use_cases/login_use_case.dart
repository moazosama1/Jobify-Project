import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/login_entity.dart';
import 'package:jobify_project/domain/entities/login_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo _repo;

  LoginUseCase(this._repo);

  Future<ApiResult<LoginEntity>> call(LoginRequestEntity request) async {
    return await _repo.login(request);
  }
}
