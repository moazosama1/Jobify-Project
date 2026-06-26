import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';
import 'package:jobify_project/domain/repo/message_repository.dart';

@injectable
class GetChatHistoryUseCase {
  final MessageRepository _repository;
  GetChatHistoryUseCase(this._repository);
  
  Future<ApiResult<List<MessageEntity>>> call(String userId, {int? page, int? limit}) {
    return _repository.getChatHistory(userId, page: page, limit: limit);
  }
}
