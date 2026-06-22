import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';

class HrChatScreenState extends BaseState<dynamic> {
  final List<MessageEntity> messages;
  final String participantName;
  final String participantAvatar;
  final String statusText;

  const HrChatScreenState({
    super.isLoading = false,
    super.errorMessage,
    this.messages = const [],
    this.participantName = '',
    this.participantAvatar = '',
    this.statusText = '',
  });

  HrChatScreenState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<MessageEntity>? messages,
    String? participantName,
    String? participantAvatar,
    String? statusText,
    bool clearError = false,
  }) {
    return HrChatScreenState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      messages: messages ?? this.messages,
      participantName: participantName ?? this.participantName,
      participantAvatar: participantAvatar ?? this.participantAvatar,
      statusText: statusText ?? this.statusText,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        messages,
        participantName,
        participantAvatar,
        statusText,
      ];
}
