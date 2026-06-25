import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/safe_api_call.dart';
import 'package:jobify_project/data/data_source/ai_chat_local_data_source.dart';
import 'package:jobify_project/data/data_source/ai_chat_remote_data_source.dart';
import 'package:jobify_project/data/mappers/ai_chat_mapper.dart';
import 'package:jobify_project/api/models/ai_chat_message_model.dart';
import 'package:jobify_project/domain/entities/ai_chat_message_entity.dart';
import 'package:jobify_project/domain/repo/ai_chat_repository.dart';

@Injectable(as: AiChatRepository)
class AiChatRepositoryImpl implements AiChatRepository {
  final AiChatRemoteDataSource _remoteDataSource;
  final AiChatLocalDataSource _localDataSource;

  AiChatRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<ApiResult<AiChatMessageEntity>> sendAiMessage(
    String message, {
    Uint8List? pdfBytes,
    List<AiChatMessageEntity>? history,
  }) async {
    final now = DateTime.now();
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    final displayHour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final userTime = "${displayHour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $amPm";

    final userMessageModel = AiChatMessageModel(
      id: "user_${DateTime.now().millisecondsSinceEpoch}",
      text: message,
      isUser: true,
      time: userTime,
    );

    final result = await safeApiCall(
      () => _remoteDataSource.sendAiMessage(message, pdfBytes: pdfBytes, history: history),
      (model) => model.toEntity(),
    );



    if (result is ApiSuccessResult<AiChatMessageEntity>) {
      try {
        final currentHistory = await _localDataSource.getChatHistory();
        final updatedHistory = List<AiChatMessageModel>.from(currentHistory)
          ..add(userMessageModel)
          ..add(result.data.toModel());
        await _localDataSource.saveChatHistory(updatedHistory);
      } catch (_) {
        // Suppress local cache write failures to ensure screen still shows updates
      }
    }

    return result;
  }

  @override
  Future<ApiResult<List<AiChatMessageEntity>>> getChatHistory() async {
    return await safeApiCall(
      () => _localDataSource.getChatHistory(),
      (models) => models.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  Future<ApiResult<void>> clearChatHistory() async {
    return await safeApiCall(
      () => _localDataSource.clearChatHistory(),
      (_) => null,
    );
  }
}
