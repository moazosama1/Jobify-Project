import 'package:injectable/injectable.dart';
import 'package:jobify_project/api/client/api_client.dart';
import 'package:jobify_project/api/models/get_chat_history_response.dart';
import 'package:jobify_project/api/models/get_conversations_response.dart';
import 'package:jobify_project/api/models/send_message_response.dart';
import 'package:jobify_project/api/models/requests/send_message_request.dart';
import 'message_remote_data_source.dart';

@Injectable(as: MessageRemoteDataSource)
class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final ApiClient _apiClient;

  MessageRemoteDataSourceImpl(this._apiClient);

  @override
  Future<SendMessageResponse> sendMessage(SendMessageRequest request) {
    return _apiClient.sendMessage(request);
  }

  @override
  Future<GetConversationsResponse> getConversations(int? page, int? limit) {
    return _apiClient.getConversations(page, limit);
  }

  @override
  Future<GetChatHistoryResponse> getConversation(String userId, int? page, int? limit) {
    return _apiClient.getConversation(userId, page, limit);
  }

  @override
  Future<dynamic> markMessageRead(String messageId) {
    return _apiClient.markMessageRead(messageId);
  }

  @override
  Future<dynamic> deleteMessage(String messageId) {
    return _apiClient.deleteMessage(messageId);
  }
}
