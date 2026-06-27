import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class GetProfileByIdUseCase {
  final AuthRepo _repo;

  GetProfileByIdUseCase(this._repo);

  Future<ApiResult<UserEntity>> call(String id) async {
    return await _repo.getProfileById(id);
  }
}
