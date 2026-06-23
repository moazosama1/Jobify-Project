import 'dart:typed_data';
import 'package:jobify_project/core/api_result/api_result.dart';
import '../entities/ai_chat_message_entity.dart';

abstract interface class AiChatRepository {
  Future<ApiResult<AiChatMessageEntity>> sendAiMessage(
    String message, {
    Uint8List? pdfBytes,
    List<AiChatMessageEntity>? history,
  });
  Future<ApiResult<List<AiChatMessageEntity>>> getChatHistory();
  Future<ApiResult<void>> clearChatHistory();
}

