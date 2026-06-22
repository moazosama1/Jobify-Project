import 'package:injectable/injectable.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class GetStoredUserRoleUseCase {
  final AuthRepo _repo;

  GetStoredUserRoleUseCase(this._repo);

  Future<String?> call() async {
    final token = await _repo.getToken();
    if (token == null || token.isEmpty) {
      return null;
    }
    return await _repo.getRole();
  }
}
