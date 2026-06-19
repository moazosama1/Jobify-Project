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
import 'package:jobify_project/domain/repo/auth_repo.dart';

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
  Future<void> logout() => _localDataSource.clear();
}
