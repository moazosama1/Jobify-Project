import 'package:injectable/injectable.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class GetStoredUserRoleUseCase {
  final AuthRepo _repo;

  GetStoredUserRoleUseCase(this._repo);

  Future<String?> call() async {
    final rememberMe = await _repo.getRememberMe();
    if (!rememberMe) {
      await _repo.clearLocalData();
      return null;
    }
    final token = await _repo.getToken();
    if (token == null || token.isEmpty) {
      return null;
    }
    return await _repo.getRole();
  }
}
