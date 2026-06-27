import 'dart:io';

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
import 'package:jobify_project/api/models/update_basic_info_request_model.dart';
import 'package:jobify_project/api/models/experience_request_model.dart';
import 'package:jobify_project/api/models/education_request_model.dart';
import 'package:jobify_project/api/models/update_skills_request_model.dart';
abstract interface class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequestDto request);
  Future<SignUPResponse> signup(SignUpRequest request, File? profileImage);
  Future<ConfirmEmailResponse> confirmEmail(ConfirmEmailRequest request);
  Future<ForgetPasswordResponse> forgetPassword(ForgetPasswordRequest request);
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);
  Future<dynamic> logout();
  Future<GetUserProfileResponse> getProfile();
  Future<GetUserProfileResponse> getProfileById(String id);
  Future<GetUserProfileResponse> updateBasicInfo(UpdateBasicInfoRequestModel request);
  Future<GetUserProfileResponse> addExperience(ExperienceRequestModel request);
  Future<GetUserProfileResponse> updateExperience(String id, ExperienceRequestModel request);
  Future<GetUserProfileResponse> deleteExperience(String id);
  Future<GetUserProfileResponse> addEducation(EducationRequestModel request);
  Future<GetUserProfileResponse> updateEducation(String id, EducationRequestModel request);
  Future<GetUserProfileResponse> deleteEducation(String id);
  Future<GetUserProfileResponse> updateSkills(UpdateSkillsRequestModel request);
  Future<GetUserProfileResponse> uploadResume(String resumeFilePath);
}
