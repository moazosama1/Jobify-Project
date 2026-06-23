import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/ai_chat_message_entity.dart';
import 'package:jobify_project/domain/use_cases/clear_ai_chat_history_use_case.dart';
import 'package:jobify_project/domain/use_cases/get_ai_chat_history_use_case.dart';
import 'package:jobify_project/domain/use_cases/send_ai_message_use_case.dart';
import 'ai_chat_events.dart';
import 'ai_chat_state.dart';

@injectable
class AiChatViewModel extends Cubit<AiChatState> {
  final SendAiMessageUseCase _sendAiMessageUseCase;
  final GetAiChatHistoryUseCase _getAiChatHistoryUseCase;
  final ClearAiChatHistoryUseCase _clearAiChatHistoryUseCase;

  AiChatViewModel(
    this._sendAiMessageUseCase,
    this._getAiChatHistoryUseCase,
    this._clearAiChatHistoryUseCase,
  ) : super(const AiChatState()) {
    _init();
  }

  void _init() {
    doIntent(const LoadAiChatHistoryEvent());
  }

  void doIntent(AiChatEvents event) {
    switch (event) {
      case LoadAiChatHistoryEvent():
        _onLoadHistory();
        break;
      case SendAiChatMessageEvent():
        _onSendMessage(event.text);
        break;
      case ClearAiChatHistoryEvent():
        _onClearHistory();
        break;
      case SelectPdfAiChatEvent():
        _onSelectPdf(event.bytes, event.name);
        break;
      case RemoveSelectedPdfAiChatEvent():
        _onRemoveSelectedPdf();
        break;
    }
  }

  void _onSelectPdf(Uint8List bytes, String name) {
    emit(state.copyWith(
      selectedPdfBytes: bytes,
      selectedPdfName: name,
    ));
  }


  void _onRemoveSelectedPdf() {
    emit(state.copyWith(
      clearPdf: true,
    ));
  }

  Future<void> _onLoadHistory() async {
    emit(
      state.copyWith(
        chatMessages: BaseState<List<AiChatMessageEntity>>(
          data: state.chatMessages.data,
          isLoading: true,
        ),
      ),
    );

    final result = await _getAiChatHistoryUseCase();

    if (result is ApiSuccessResult<List<AiChatMessageEntity>>) {
      emit(
        state.copyWith(
          chatMessages: BaseState<List<AiChatMessageEntity>>.success(
            result.data,
          ),
        ),
      );
    } else if (result is ApiErrorResult<List<AiChatMessageEntity>>) {
      emit(
        state.copyWith(
          chatMessages: BaseState<List<AiChatMessageEntity>>.error(
            result.errorMessage,
          ),
        ),
      );
    }
  }

  Future<void> _onSendMessage(String text) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) return;

    final now = DateTime.now();
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    final displayHour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);
    final userTime =
        "${displayHour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $amPm";

    final pdfName = state.selectedPdfName;
    final pdfBytes = state.selectedPdfBytes;

    final displayText = pdfName != null 
        ? "📄 **$pdfName**\n\n$cleanText"
        : cleanText;

    final tempUserMessage = AiChatMessageEntity(
      id: "temp_${now.millisecondsSinceEpoch}",
      text: displayText,
      isUser: true,
      time: userTime,
    );

    final currentMessages = state.chatMessages.data ?? const [];
    final updatedMessages = List<AiChatMessageEntity>.from(currentMessages)
      ..add(tempUserMessage);

    emit(
      state.copyWith(
        chatMessages: BaseState<List<AiChatMessageEntity>>(
          data: updatedMessages,
          isLoading: false,
        ),
        sendMessageStatus: BaseState.loading(),
        clearError: true,
        clearPdf: true,
      ),
    );

    final result = await _sendAiMessageUseCase(
      cleanText,
      pdfBytes: pdfBytes,
      history: currentMessages,
    );

    if (result is ApiSuccessResult<AiChatMessageEntity>) {
      final historyResult = await _getAiChatHistoryUseCase();
      if (historyResult is ApiSuccessResult<List<AiChatMessageEntity>>) {
        emit(
          state.copyWith(
            chatMessages: BaseState<List<AiChatMessageEntity>>.success(
              historyResult.data,
            ),
            sendMessageStatus: BaseState<AiChatMessageEntity>.success(
              result.data,
            ),
          ),
        );
      } else {
        final listWithAi = List<AiChatMessageEntity>.from(updatedMessages)
          ..add(result.data);
        emit(
          state.copyWith(
            chatMessages: BaseState<List<AiChatMessageEntity>>.success(
              listWithAi,
            ),
            sendMessageStatus: BaseState<AiChatMessageEntity>.success(
              result.data,
            ),
          ),
        );
      }
    } else if (result is ApiErrorResult<AiChatMessageEntity>) {
      emit(
        state.copyWith(
          sendMessageStatus: BaseState<AiChatMessageEntity>.error(
            result.errorMessage,
          ),
        ),
      );
    }
  }

  Future<void> _onClearHistory() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await _clearAiChatHistoryUseCase();

    if (result is ApiSuccessResult<void>) {
      emit(
        state.copyWith(
          isLoading: false,
          chatMessages: const BaseState<List<AiChatMessageEntity>>(data: []),
          sendMessageStatus: const BaseState<AiChatMessageEntity>(),
        ),
      );
    } else if (result is ApiErrorResult<void>) {
      emit(state.copyWith(isLoading: false, errorMessage: result.errorMessage));
    }
  }
}

