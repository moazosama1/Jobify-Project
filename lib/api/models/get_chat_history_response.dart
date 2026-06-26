import 'package:json_annotation/json_annotation.dart';
import 'message_response.dart';
import 'conversation_response.dart';
part 'get_chat_history_response.g.dart';

@JsonSerializable()
class GetChatHistoryResponse {
  final String? message;
  final ConversationOtherUserResponse? otherUser;
  final List<MessageResponse>? messages;

  GetChatHistoryResponse(this.message, this.otherUser, this.messages);

  factory GetChatHistoryResponse.fromJson(Map<String, dynamic> json) => _$GetChatHistoryResponseFromJson(json);
}
