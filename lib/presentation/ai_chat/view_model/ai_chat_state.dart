import 'dart:typed_data';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/ai_chat_message_entity.dart';

class AiChatState extends BaseState<dynamic> {
  final BaseState<List<AiChatMessageEntity>> chatMessages;
  final BaseState<AiChatMessageEntity> sendMessageStatus;
  final Uint8List? selectedPdfBytes;
  final String? selectedPdfName;

  const AiChatState({
    super.isLoading = false,
    super.errorMessage,
    this.chatMessages = const BaseState<List<AiChatMessageEntity>>(data: []),
    this.sendMessageStatus = const BaseState<AiChatMessageEntity>(),
    this.selectedPdfBytes,
    this.selectedPdfName,
  });

  AiChatState copyWith({
    bool? isLoading,
    String? errorMessage,
    BaseState<List<AiChatMessageEntity>>? chatMessages,
    BaseState<AiChatMessageEntity>? sendMessageStatus,
    Uint8List? selectedPdfBytes,
    String? selectedPdfName,
    bool clearError = false,
    bool clearPdf = false,
  }) {
    return AiChatState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      chatMessages: chatMessages ?? this.chatMessages,
      sendMessageStatus: sendMessageStatus ?? this.sendMessageStatus,
      selectedPdfBytes: clearPdf ? null : (selectedPdfBytes ?? this.selectedPdfBytes),
      selectedPdfName: clearPdf ? null : (selectedPdfName ?? this.selectedPdfName),
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        chatMessages,
        sendMessageStatus,
        selectedPdfBytes,
        selectedPdfName,
      ];
}

