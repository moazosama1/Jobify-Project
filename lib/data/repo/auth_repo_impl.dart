import 'package:injectable/injectable.dart';
import 'package:jobify_project/data/mappers/auth_mapper.dart';
import 'package:jobify_project/api/models/requests/login_request_dto.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/safe_api_call.dart';
import 'package:jobify_project/data/data_source/auth_local_data_source.dart';
import 'package:jobify_project/data/data_source/auth_remote_data_source.dart';
import 'package:jobify_project/domain/entities/login_entity.dart';
import 'package:jobify_project/domain/entities/login_request_entity.dart';
import 'package:jobify_project/domain/entities/signup_entity.dart';
import 'package:jobify_project/domain/entities/signup_request_entity.dart';
import 'package:jobify_project/domain/entities/confirm_email_request_entity.dart';
import 'package:jobify_project/domain/entities/confirm_email_entity.dart';
import 'package:jobify_project/domain/entities/forget_password_request_entity.dart';
import 'package:jobify_project/domain/entities/forget_password_entity.dart';
import 'package:jobify_project/domain/entities/reset_password_request_entity.dart';
import 'package:jobify_project/domain/entities/reset_password_entity.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/repo/auth_repo.dart';
import 'package:jobify_project/domain/entities/update_basic_info_request_entity.dart';
import 'package:jobify_project/domain/entities/experience_request_entity.dart';
import 'package:jobify_project/domain/entities/education_request_entity.dart';
import 'package:jobify_project/domain/entities/update_skills_request_entity.dart';
import 'package:jobify_project/api/models/update_basic_info_request_model.dart';
import 'package:jobify_project/api/models/experience_request_model.dart';
import 'package:jobify_project/api/models/education_request_model.dart';
import 'package:jobify_project/api/models/update_skills_request_model.dart';
@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<ApiResult<LoginEntity>> login(LoginRequestEntity request) async {
    final result = await safeApiCall(
      () => _remoteDataSource.login(
        LoginRequestDto(
          email: request.email,
          password: request.password,
        ),
      ),
      (response) => response.toEntity(),
    );

    if (result is ApiSuccessResult<LoginEntity>) {
      await _localDataSource.saveToken(result.data.accessToken);
      await _localDataSource.saveRole(result.data.user.role);
      await _localDataSource.saveRememberMe(request.rememberMe);
    }

    return result;
  }

  @override
  Future<ApiResult<SignUpEntity>> signup(SignUpRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.signup(request.toModel()),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<ConfirmEmailEntity>> confirmEmail(ConfirmEmailRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.confirmEmail(request.toModel()),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<ForgetPasswordEntity>> forgetPassword(ForgetPasswordRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.forgetPassword(request.toModel()),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword(ResetPasswordRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.resetPassword(request.toModel()),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<String?> getToken() => _localDataSource.getToken();

  @override
  Future<String?> getRole() => _localDataSource.getRole();

  @override
  Future<ApiResult<void>> logout() async {
    final result = await safeApiCall(
      () => _remoteDataSource.logout(),
      (response) {},
    );
    if (result is ApiSuccessResult) {
      await _localDataSource.clear();
    }
    return result;
  }

  @override
  Future<void> saveRememberMe(bool value) => _localDataSource.saveRememberMe(value);

  @override
  Future<bool> getRememberMe() => _localDataSource.getRememberMe();

  @override
  Future<void> clearLocalData() => _localDataSource.clear();

  @override
  Future<ApiResult<UserEntity>> getProfile() async {
    return await safeApiCall(
      () => _remoteDataSource.getProfile(),
      (response) => response.user.toEntity(),
    );
  }

  @override
  Future<ApiResult<UserEntity>> updateBasicInfo(UpdateBasicInfoRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.updateBasicInfo(UpdateBasicInfoRequestModel.fromEntity(request)),
      (response) => response.user.toEntity(),
    );
  }

  @override
  Future<ApiResult<UserEntity>> addExperience(ExperienceRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.addExperience(ExperienceRequestModel.fromEntity(request)),
      (response) => response.user.toEntity(),
    );
  }

  @override
  Future<ApiResult<UserEntity>> updateExperience(String id, ExperienceRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.updateExperience(id, ExperienceRequestModel.fromEntity(request)),
      (response) => response.user.toEntity(),
    );
  }

  @override
  Future<ApiResult<UserEntity>> deleteExperience(String id) async {
    return await safeApiCall(
      () => _remoteDataSource.deleteExperience(id),
      (response) => response.user.toEntity(),
    );
  }

  @override
  Future<ApiResult<UserEntity>> addEducation(EducationRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.addEducation(EducationRequestModel.fromEntity(request)),
      (response) => response.user.toEntity(),
    );
  }

  @override
  Future<ApiResult<UserEntity>> updateEducation(String id, EducationRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.updateEducation(id, EducationRequestModel.fromEntity(request)),
      (response) => response.user.toEntity(),
    );
  }

  @override
  Future<ApiResult<UserEntity>> deleteEducation(String id) async {
    return await safeApiCall(
      () => _remoteDataSource.deleteEducation(id),
      (response) => response.user.toEntity(),
    );
  }

  @override
  Future<ApiResult<UserEntity>> updateSkills(UpdateSkillsRequestEntity request) async {
    return await safeApiCall(
      () => _remoteDataSource.updateSkills(UpdateSkillsRequestModel.fromEntity(request)),
      (response) => response.user.toEntity(),
    );
  }

  @override
  Future<ApiResult<UserEntity>> uploadResume(String resumeFilePath) async {
    return await safeApiCall(
      () => _remoteDataSource.uploadResume(resumeFilePath),
      (response) => response.user.toEntity(),
    );
  }
}

