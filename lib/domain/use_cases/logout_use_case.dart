import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class LogoutUseCase {
  final AuthRepo _repo;

  LogoutUseCase(this._repo);

  Future<ApiResult<void>> call() async {
    return await _repo.logout();
  }
}
