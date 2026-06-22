import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/api/models/login_response.dart';
import 'package:jobify_project/api/models/requests/login_request_dto.dart';
import 'package:jobify_project/api/models/requests/signup_request.dart';
import 'package:jobify_project/api/models/signup_response.dart';
import 'package:jobify_project/api/models/requests/confirm_email_request.dart';
import 'package:jobify_project/api/models/confirm_email_response.dart';
import 'package:jobify_project/api/models/requests/forget_password_request.dart';
import 'package:jobify_project/api/models/forget_password_response.dart';
import 'package:jobify_project/api/models/requests/reset_password_request.dart';
import 'package:jobify_project/api/models/reset_password_response.dart';
import 'package:jobify_project/core/constants/end_points.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(EndPoints.signIn)
  Future<LoginResponse> login(@Body() LoginRequestDto request);

  @POST(EndPoints.signup)
  Future<SignUPResponse> signup(@Body() SignUpRequest request);

  @POST(EndPoints.confirmEmail)
  Future<ConfirmEmailResponse> confirmEmail(@Body() ConfirmEmailRequest request);

  @PATCH(EndPoints.forgetPassward)
  Future<ForgetPasswordResponse> forgetPassword(@Body() ForgetPasswordRequest request);

  @PATCH(EndPoints.resetPassward)
  Future<ResetPasswordResponse> resetPassword(@Body() ResetPasswordRequest request);
}
