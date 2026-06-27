import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';

class ChatScreenState extends BaseState<List<MessageEntity>> {
  final String receiverId;
  final String participantName;
  final String participantAvatar;
  final String statusText;

  const ChatScreenState({
    super.isLoading = false,
    super.errorMessage,
    super.data = const [],
    this.receiverId = '',
    this.participantName = '',
    this.participantAvatar = '',
    this.statusText = '',
  });

  ChatScreenState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<MessageEntity>? data,
    String? receiverId,
    String? participantName,
    String? participantAvatar,
    String? statusText,
    bool clearError = false,
  }) {
    return ChatScreenState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      data: data ?? this.data,
      receiverId: receiverId ?? this.receiverId,
      participantName: participantName ?? this.participantName,
      participantAvatar: participantAvatar ?? this.participantAvatar,
      statusText: statusText ?? this.statusText,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        data,
        receiverId,
        participantName,
        participantAvatar,
        statusText,
      ];
}
