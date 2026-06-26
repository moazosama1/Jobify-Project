import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/conversation_entity.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';

abstract class MessageRepository {
  Future<ApiResult<List<ConversationEntity>>> getConversations({int? page, int? limit});
  Future<ApiResult<List<MessageEntity>>> getChatHistory(String userId, {int? page, int? limit});
  Future<ApiResult<MessageEntity>> sendMessage(String receiverId, String content);
  Future<ApiResult<void>> markMessageRead(String messageId);
  Future<ApiResult<void>> deleteMessage(String messageId);
}
