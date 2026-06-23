import 'package:jobify_project/data/models/ai_chat_message_model.dart';

abstract interface class AiChatLocalDataSource {
  Future<List<AiChatMessageModel>> getChatHistory();
  Future<void> saveChatHistory(List<AiChatMessageModel> history);
  Future<void> clearChatHistory();
}
