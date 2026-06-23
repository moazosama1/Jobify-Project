import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/ai_chat_message_entity.dart';
import 'package:jobify_project/domain/repo/ai_chat_repository.dart';

@injectable
class SendAiMessageUseCase {
  final AiChatRepository _repo;

  SendAiMessageUseCase(this._repo);

  Future<ApiResult<AiChatMessageEntity>> call(
    String message, {
    Uint8List? pdfBytes,
    List<AiChatMessageEntity>? history,
  }) async {
    return await _repo.sendAiMessage(message, pdfBytes: pdfBytes, history: history);
  }
}

