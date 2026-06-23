import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/ai_chat_message_entity.dart';
import 'package:jobify_project/domain/repo/ai_chat_repository.dart';

@injectable
class GetAiChatHistoryUseCase {
  final AiChatRepository _repo;

  GetAiChatHistoryUseCase(this._repo);

  Future<ApiResult<List<AiChatMessageEntity>>> call() async {
    return await _repo.getChatHistory();
  }
}
