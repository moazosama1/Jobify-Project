import 'package:jobify_project/api/models/login_response.dart';
import 'package:jobify_project/api/models/signup_response.dart';
import 'package:jobify_project/api/models/requests/signup_request.dart';
import 'package:jobify_project/api/models/requests/confirm_email_request.dart';
import 'package:jobify_project/api/models/confirm_email_response.dart';
import 'package:jobify_project/api/models/requests/forget_password_request.dart';
import 'package:jobify_project/api/models/forget_password_response.dart';
import 'package:jobify_project/api/models/requests/reset_password_request.dart';
import 'package:jobify_project/api/models/reset_password_response.dart';
import 'package:jobify_project/api/models/user_dto.dart';
import 'package:jobify_project/domain/entities/login_entity.dart';
import 'package:jobify_project/domain/entities/signup_entity.dart';
import 'package:jobify_project/domain/entities/signup_request_entity.dart';
import 'package:jobify_project/domain/entities/confirm_email_request_entity.dart';
import 'package:jobify_project/domain/entities/confirm_email_entity.dart';
import 'package:jobify_project/domain/entities/forget_password_request_entity.dart';
import 'package:jobify_project/domain/entities/forget_password_entity.dart';
import 'package:jobify_project/domain/entities/reset_password_request_entity.dart';
import 'package:jobify_project/domain/entities/reset_password_entity.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';

extension UserDtoMapper on UserDto {
  UserEntity toEntity() {
    return UserEntity(
      mongoId: mongoId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      provider: provider,
      password: password,
      age: age,
      gender: gender,
      phoneNumber: phoneNumber,
      location: location,
      role: role,
      skills: skills,
      jobTypePreferences: jobTypePreferences,
      savedJobs: savedJobs,
      confirmed: confirmed,
      friends: friends,
      blockedUsers: blockedUsers,
      isActive: isActive,
      notificationsEnabled: notificationsEnabled,
      experience: experience,
      education: education,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      version: version,
      userName: userName,
      id: id,
    );
  }
}

extension UserEntityMapper on UserEntity {
  UserDto toModel() {
    return UserDto(
      mongoId: mongoId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      provider: provider,
      password: password,
      age: age,
      gender: gender,
      phoneNumber: phoneNumber,
      location: location,
      role: role,
      skills: skills,
      jobTypePreferences: jobTypePreferences,
      savedJobs: savedJobs,
      confirmed: confirmed,
      friends: friends,
      blockedUsers: blockedUsers,
      isActive: isActive,
      notificationsEnabled: notificationsEnabled,
      experience: experience,
      education: education,
      createdAt: createdAt,
      updatedAt: updatedAt,
      version: version,
      userName: userName,
      id: id,
    );
  }
}

extension UserDataMapper on UserData {
  UserEntity toEntity() {
    return UserEntity(
      mongoId: mongoId ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      provider: provider ?? '',
      password: password,
      age: age ?? 0,
      gender: gender ?? '',
      phoneNumber: phoneNumber ?? '',
      location: location ?? '',
      role: role ?? '',
      skills: skills ?? const [],
      jobTypePreferences: jobTypePreferences ?? const [],
      savedJobs: savedJobs ?? const [],
      confirmed: confirmed ?? false,
      friends: friends ?? const [],
      blockedUsers: blockedUsers ?? const [],
      isActive: isActive ?? false,
      notificationsEnabled: notificationsEnabled ?? false,
      experience: experience ?? const [],
      education: education ?? const [],
      createdAt: createdAt != null
          ? DateTime.tryParse(createdAt!) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: updatedAt != null
          ? DateTime.tryParse(updatedAt!) ?? DateTime.now()
          : DateTime.now(),
      version: v ?? 0,
      userName: userName ?? '',
      id: id ?? '',
    );
  }
}

extension LoginResponseMapper on LoginResponse {
  LoginEntity toEntity() {
    return LoginEntity(
      message: message,
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user.toEntity(),
    );
  }
}

extension SignUPResponseMapper on SignUPResponse {
  SignUpEntity toEntity() {
    return SignUpEntity(message: message ?? '', user: user?.toEntity());
  }
}

extension SignUpRequestEntityMapper on SignUpRequestEntity {
  SignUpRequest toModel() {
    return SignUpRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      cPassword: cPassword,
      age: age,
      location: location,
      phoneNumber: phoneNumber,
      gender: gender,
      role: role,
    );
  }
}

extension ConfirmEmailRequestEntityMapper on ConfirmEmailRequestEntity {
  ConfirmEmailRequest toModel() {
    return ConfirmEmailRequest(email: email, otp: otp);
  }
}

extension ConfirmEmailResponseMapper on ConfirmEmailResponse {
  ConfirmEmailEntity toEntity() {
    return ConfirmEmailEntity(message: message ?? '');
  }
}

extension ForgetPasswordRequestEntityMapper on ForgetPasswordRequestEntity {
  ForgetPasswordRequest toModel() {
    return ForgetPasswordRequest(email: email);
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse {
  ForgetPasswordEntity toEntity() {
    return ForgetPasswordEntity(message: message ?? '');
  }
}

extension ResetPasswordRequestEntityMapper on ResetPasswordRequestEntity {
  ResetPasswordRequest toModel() {
    return ResetPasswordRequest(
      email: email,
      otp: otp,
      password: password,
      cPassword: cPassword,
    );
  }
}

extension ResetPasswordResponseMapper on ResetPasswordResponse {
  ResetPasswordEntity toEntity() {
    return ResetPasswordEntity(message: message ?? '');
  }
}
