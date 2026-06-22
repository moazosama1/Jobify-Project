import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/messages_entity.dart';

class MessagesState extends BaseState<dynamic> {
  final List<MessagesEntity> chats;

  const MessagesState({
    super.isLoading = false,
    super.errorMessage,
    this.chats = const [],
  });

  MessagesState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<MessagesEntity>? chats,
    bool clearError = false,
  }) {
    return MessagesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, chats];
}
