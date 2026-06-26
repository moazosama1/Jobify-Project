import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';
import 'package:jobify_project/domain/repo/message_repository.dart';

@injectable
class SendMessageUseCase {
  final MessageRepository _repository;
  SendMessageUseCase(this._repository);
  
  Future<ApiResult<MessageEntity>> call(String receiverId, String content) {
    return _repository.sendMessage(receiverId, content);
  }
}
