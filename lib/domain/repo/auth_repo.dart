import 'package:jobify_project/core/api_result/api_result.dart';
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

abstract interface class AuthRepo {
  Future<ApiResult<LoginEntity>> login(LoginRequestEntity request);
  Future<ApiResult<SignUpEntity>> signup(SignUpRequestEntity request);
  Future<ApiResult<ConfirmEmailEntity>> confirmEmail(ConfirmEmailRequestEntity request);
  Future<ApiResult<ForgetPasswordEntity>> forgetPassword(ForgetPasswordRequestEntity request);
  Future<ApiResult<ResetPasswordEntity>> resetPassword(ResetPasswordRequestEntity request);
  Future<String?> getToken();
  Future<String?> getRole();
  Future<ApiResult<void>> logout();
}
