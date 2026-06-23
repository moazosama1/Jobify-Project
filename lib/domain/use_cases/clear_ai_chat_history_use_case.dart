import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/repo/ai_chat_repository.dart';

@injectable
class ClearAiChatHistoryUseCase {
  final AiChatRepository _repo;

  ClearAiChatHistoryUseCase(this._repo);

  Future<ApiResult<void>> call() async {
    return await _repo.clearChatHistory();
  }
}
