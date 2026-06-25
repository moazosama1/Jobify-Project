import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/api/client/api_client.dart';
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
import 'package:jobify_project/api/models/get_user_profile_response.dart';
import 'package:jobify_project/data/data_source/auth_remote_data_source.dart';
import 'package:jobify_project/api/models/update_basic_info_request_model.dart';
import 'package:jobify_project/api/models/experience_request_model.dart';
import 'package:jobify_project/api/models/education_request_model.dart';
import 'package:jobify_project/api/models/update_skills_request_model.dart';
import 'dart:io';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LoginResponse> login(LoginRequestDto request) {
    return _apiClient.login(request);
  }

  @override
  Future<SignUPResponse> signup(
    SignUpRequest request,
    File? profileImage,
  ) async {
    MultipartFile? multipartFile;
    if (profileImage != null) {
      final ext = profileImage.path.split('.').last.toLowerCase();
      final MediaType mediaType;
      if (ext == 'png') {
        mediaType = MediaType('image', 'png');
      } else if (ext == 'gif') {
        mediaType = MediaType('image', 'gif');
      } else if (ext == 'webp') {
        mediaType = MediaType('image', 'webp');
      } else if (ext == 'jpg' || ext == 'jpeg') {
        mediaType = MediaType('image', 'jpeg');
      } else if (ext == 'bmp') {
        mediaType = MediaType('image', 'bmp');
      } else if (ext == 'heic' || ext == 'heif') {
        mediaType = MediaType('image', 'heic');
      } else {
        mediaType = MediaType('image', 'jpeg');
      }

      multipartFile = await MultipartFile.fromFile(
        profileImage.path,
        filename: profileImage.path.split(RegExp(r'[/\\]')).last,
        contentType: mediaType,
      );
    }

    return _apiClient.signup(
      request.firstName,
      request.lastName,
      request.email,
      request.password,
      request.cPassword,
      request.age,
      request.location,
      request.phoneNumber,
      request.gender,
      request.role,
      multipartFile,
    );
  }

  @override
  Future<ConfirmEmailResponse> confirmEmail(ConfirmEmailRequest request) {
    return _apiClient.confirmEmail(request);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(ForgetPasswordRequest request) {
    return _apiClient.forgetPassword(request);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) {
    return _apiClient.resetPassword(request);
  }

  @override
  Future<dynamic> logout() {
    return _apiClient.logout({"flag": "all"});
  }

  @override
  Future<GetUserProfileResponse> getProfile() {
    return _apiClient.getProfile();
  }

  @override
  Future<GetUserProfileResponse> updateBasicInfo(
    UpdateBasicInfoRequestModel request,
  ) {
    return _apiClient.updateBasicInfo(
      request.toJson()..removeWhere((key, value) => value == null),
    );
  }

  @override
  Future<GetUserProfileResponse> addExperience(ExperienceRequestModel request) {
    return _apiClient.addExperience(
      request.toJson()..removeWhere((key, value) => value == null),
    );
  }

  @override
  Future<GetUserProfileResponse> updateExperience(
    String id,
    ExperienceRequestModel request,
  ) {
    return _apiClient.updateExperience(
      id,
      request.toJson()..removeWhere((key, value) => value == null),
    );
  }

  @override
  Future<GetUserProfileResponse> deleteExperience(String id) {
    return _apiClient.deleteExperience(id);
  }

  @override
  Future<GetUserProfileResponse> addEducation(EducationRequestModel request) {
    return _apiClient.addEducation(
      request.toJson()..removeWhere((key, value) => value == null),
    );
  }

  @override
  Future<GetUserProfileResponse> updateEducation(
    String id,
    EducationRequestModel request,
  ) {
    return _apiClient.updateEducation(
      id,
      request.toJson()..removeWhere((key, value) => value == null),
    );
  }

  @override
  Future<GetUserProfileResponse> deleteEducation(String id) {
    return _apiClient.deleteEducation(id);
  }

  @override
  Future<GetUserProfileResponse> updateSkills(
    UpdateSkillsRequestModel request,
  ) {
    return _apiClient.updateSkills(
      request.toJson()..removeWhere((key, value) => value == null),
    );
  }

  @override
  Future<GetUserProfileResponse> uploadResume(String resumeFilePath) {
    return _apiClient.uploadResume(File(resumeFilePath));
  }
}
