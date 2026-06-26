import 'package:jobify_project/api/models/get_chat_history_response.dart';
import 'package:jobify_project/api/models/get_conversations_response.dart';
import 'package:jobify_project/api/models/send_message_response.dart';
import 'package:jobify_project/api/models/requests/send_message_request.dart';

abstract class MessageRemoteDataSource {
  Future<SendMessageResponse> sendMessage(SendMessageRequest request);
  Future<GetConversationsResponse> getConversations(int? page, int? limit);
  Future<GetChatHistoryResponse> getConversation(String userId, int? page, int? limit);
  Future<dynamic> markMessageRead(String messageId);
  Future<dynamic> deleteMessage(String messageId);
}
