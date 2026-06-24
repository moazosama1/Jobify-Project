import 'package:jobify_project/api/models/login_response.dart';
import 'package:jobify_project/api/models/signup_response.dart';
import 'package:jobify_project/api/models/requests/login_request_dto.dart';
import 'package:jobify_project/api/models/requests/signup_request.dart';
import 'package:jobify_project/api/models/requests/confirm_email_request.dart';
import 'package:jobify_project/api/models/confirm_email_response.dart';
import 'package:jobify_project/api/models/requests/forget_password_request.dart';
import 'package:jobify_project/api/models/forget_password_response.dart';
import 'package:jobify_project/api/models/requests/reset_password_request.dart';
import 'package:jobify_project/api/models/reset_password_response.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequestDto request);
  Future<SignUPResponse> signup(SignUpRequest request);
  Future<ConfirmEmailResponse> confirmEmail(ConfirmEmailRequest request);
  Future<ForgetPasswordResponse> forgetPassword(ForgetPasswordRequest request);
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);
  Future<dynamic> logout();
}
