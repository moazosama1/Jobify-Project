import 'package:json_annotation/json_annotation.dart';
import 'conversation_response.dart';
part 'get_conversations_response.g.dart';

@JsonSerializable()
class GetConversationsResponse {
  final String? message;
  final List<ConversationResponse>? conversations;

  GetConversationsResponse(this.message, this.conversations);

  factory GetConversationsResponse.fromJson(Map<String, dynamic> json) => _$GetConversationsResponseFromJson(json);
}
