import 'package:jobify_project/api/models/ai_chat_message_model.dart';
import 'package:jobify_project/domain/entities/ai_chat_message_entity.dart';

extension AiChatMessageModelMapper on AiChatMessageModel {
  AiChatMessageEntity toEntity() {
    return AiChatMessageEntity(
      id: id,
      text: text,
      isUser: isUser,
      time: time,
    );
  }
}

extension AiChatMessageEntityMapper on AiChatMessageEntity {
  AiChatMessageModel toModel() {
    return AiChatMessageModel(
      id: id,
      text: text,
      isUser: isUser,
      time: time,
    );
  }
}
