import 'dart:typed_data';
import 'package:jobify_project/api/models/ai_chat_message_model.dart';
import 'package:jobify_project/domain/entities/ai_chat_message_entity.dart';

abstract interface class AiChatRemoteDataSource {
  Future<AiChatMessageModel> sendAiMessage(
    String message, {
    Uint8List? pdfBytes,
    List<AiChatMessageEntity>? history,
  });
}

