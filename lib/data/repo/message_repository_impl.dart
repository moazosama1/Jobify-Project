import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/safe_api_call.dart';
import 'package:jobify_project/domain/entities/conversation_entity.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';
import 'package:jobify_project/domain/repo/message_repository.dart';
import 'package:jobify_project/api/data_source/message_remote_data_source.dart';
import 'package:jobify_project/api/models/requests/send_message_request.dart';
import 'package:jobify_project/core/utils/secure_storage_manager.dart';
import 'package:jobify_project/core/constants/const_keys.dart';

@Injectable(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource _remoteDataSource;
  final SecureStorageManager _secureStorageManager;

  MessageRepositoryImpl(this._remoteDataSource, this._secureStorageManager);

  Future<String> _getCurrentUserId() async {
    try {
      final token = await _secureStorageManager.getString(key: ConstKeys.kUserToken);
      if (token != null) {
        final parts = token.split('.');
        if (parts.length == 3) {
          final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
          final payloadMap = jsonDecode(payload);
          return payloadMap['id'] ?? payloadMap['_id'] ?? "";
        }
      }
    } catch (e) {
      // ignore
    }
    return "";
  }

  @override
  Future<ApiResult<List<ConversationEntity>>> getConversations({int? page, int? limit}) async {
    final currentUserId = await _getCurrentUserId();
    return await safeApiCall(
      () => _remoteDataSource.getConversations(page, limit),
      (response) => response.conversations?.map((c) => c.toEntity(currentUserId)).toList() ?? [],
    );
  }

  @override
  Future<ApiResult<List<MessageEntity>>> getChatHistory(String userId, {int? page, int? limit}) async {
    final currentUserId = await _getCurrentUserId();
    return await safeApiCall(
      () => _remoteDataSource.getConversation(userId, page, limit),
      (response) => response.messages?.map((m) => m.toEntity(currentUserId)).toList() ?? [],
    );
  }

  @override
  Future<ApiResult<MessageEntity>> sendMessage(String receiverId, String content) async {
    final currentUserId = await _getCurrentUserId();
    return await safeApiCall(
      () => _remoteDataSource.sendMessage(SendMessageRequest(receiverId: receiverId, content: content)),
      (response) => response.data?.toEntity(currentUserId) ?? MessageEntity(id: "", text: "", time: "", isMe: true),
    );
  }

  @override
  Future<ApiResult<void>> markMessageRead(String messageId) async {
    return await safeApiCall(
      () => _remoteDataSource.markMessageRead(messageId),
      (response) {},
    );
  }

  @override
  Future<ApiResult<void>> deleteMessage(String messageId) async {
    return await safeApiCall(
      () => _remoteDataSource.deleteMessage(messageId),
      (response) {},
    );
  }
}
