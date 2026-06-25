import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';

@injectable
class UploadResumeUseCase {
  final AuthRepo _authRepo;

  const UploadResumeUseCase(this._authRepo);

  Future<ApiResult<UserEntity>> call(String resumeFilePath) async {
    return await _authRepo.uploadResume(resumeFilePath);
  }
}
