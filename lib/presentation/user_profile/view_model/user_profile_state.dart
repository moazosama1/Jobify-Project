import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';

class UserProfileState extends BaseState<UserEntity> {
  const UserProfileState({
    super.isLoading = false,
    super.errorMessage,
    super.data,
  });

  UserProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserEntity? data,
    bool clearError = false,
  }) {
    return UserProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, data];
}
