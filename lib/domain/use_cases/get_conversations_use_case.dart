import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/conversation_entity.dart';
import 'package:jobify_project/domain/repo/message_repository.dart';

@injectable
class GetConversationsUseCase {
  final MessageRepository _repository;
  GetConversationsUseCase(this._repository);
  
  Future<ApiResult<List<ConversationEntity>>> call({int? page, int? limit}) {
    return _repository.getConversations(page: page, limit: limit);
  }
}
