import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignUPResponse {
  final String? message;
  final UserData? user;

  SignUPResponse({this.message, this.user});

  factory SignUPResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUPResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUPResponseToJson(this);
}

@JsonSerializable()
class UserData {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? provider;
  final String? password;
  final int? age;
  final String? gender;
  final String? phoneNumber;
  final String? location;
  final String? otp;
  final String? role;
  final List<dynamic>? skills;
  final List<dynamic>? jobTypePreferences;
  final List<dynamic>? savedJobs;
  final bool? confirmed;
  final List<dynamic>? friends;
  final List<dynamic>? blockedUsers;
  final bool? isActive;
  final bool? notificationsEnabled;
  @JsonKey(name: '_id')
  final String? mongoId;
  final List<dynamic>? experience;
  final List<dynamic>? education;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  final String? userName;
  final String? id;

  UserData({
    this.firstName,
    this.lastName,
    this.email,
    this.provider,
    this.password,
    this.age,
    this.gender,
    this.phoneNumber,
    this.location,
    this.otp,
    this.role,
    this.skills,
    this.jobTypePreferences,
    this.savedJobs,
    this.confirmed,
    this.friends,
    this.blockedUsers,
    this.isActive,
    this.notificationsEnabled,
    this.mongoId,
    this.experience,
    this.education,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.userName,
    this.id,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}