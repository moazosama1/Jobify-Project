import 'package:json_annotation/json_annotation.dart';

part 'confirm_email_request.g.dart';

@JsonSerializable()
class ConfirmEmailRequest {
  final String email;
  final String otp;

  ConfirmEmailRequest({
    required this.email,
    required this.otp,
  });

  factory ConfirmEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmEmailRequestToJson(this);
}
