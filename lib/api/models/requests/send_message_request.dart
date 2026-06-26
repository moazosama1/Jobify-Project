import 'package:json_annotation/json_annotation.dart';
part 'send_message_request.g.dart';

@JsonSerializable()
class SendMessageRequest {
  final String receiverId;
  final String content;

  SendMessageRequest({required this.receiverId, required this.content});

  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}
