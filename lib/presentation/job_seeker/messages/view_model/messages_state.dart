import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/messages_entity.dart';

class MessagesState extends BaseState<List<MessagesEntity>> {
  const MessagesState({
    super.isLoading = false,
    super.errorMessage,
    super.data = const [],
  });

  MessagesState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<MessagesEntity>? data,
    bool clearError = false,
  }) {
    return MessagesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        data,
      ];
}
