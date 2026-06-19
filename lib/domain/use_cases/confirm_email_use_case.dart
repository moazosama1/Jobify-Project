import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/confirm_email_entity.dart';
import 'package:jobify_project/domain/entities/confirm_email_request_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class ConfirmEmailUseCase {
  final AuthRepo _repo;

  ConfirmEmailUseCase(this._repo);

  Future<ApiResult<ConfirmEmailEntity>> call(ConfirmEmailRequestEntity request) async {
    return await _repo.confirmEmail(request);
  }
}
