import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/signup_entity.dart';
import 'package:jobify_project/domain/entities/signup_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class SignUpUseCase {
  final AuthRepo _repo;

  SignUpUseCase(this._repo);

  Future<ApiResult<SignUpEntity>> call(SignUpRequestEntity request) async {
    return await _repo.signup(request);
  }
}
