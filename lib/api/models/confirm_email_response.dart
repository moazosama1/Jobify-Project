import 'package:json_annotation/json_annotation.dart';

part 'confirm_email_response.g.dart';

@JsonSerializable()
class ConfirmEmailResponse {
  final String? message;

  ConfirmEmailResponse({this.message});

  factory ConfirmEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmEmailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmEmailResponseToJson(this);
}
