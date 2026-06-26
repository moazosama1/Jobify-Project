import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/api/models/message_response.dart';
part 'send_message_response.g.dart';

@JsonSerializable()
class SendMessageResponse {
  final String? message;
  final MessageResponse? data;

  SendMessageResponse(this.message, this.data);

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) => _$SendMessageResponseFromJson(json);
}
