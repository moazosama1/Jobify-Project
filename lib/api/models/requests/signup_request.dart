import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable()
class SignUpRequest {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? cPassword;
  final int? age;
  final String? location;
  final String? phoneNumber;
  final String? gender;
  final String? role;

  SignUpRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.cPassword,
    this.age,
    this.location,
    this.phoneNumber,
    this.gender,
    this.role,
  });

  // تحويل من JSON إلى Object
  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  // تحويل من Object إلى JSON لإرساله للسيرفر
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}