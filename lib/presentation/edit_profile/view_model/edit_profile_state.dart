import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';

class EditProfileState extends Equatable {
  final BaseState<UserEntity> profileState;
  final String? successMessage;

  const EditProfileState({
    this.profileState = const BaseState<UserEntity>(),
    this.successMessage,
  });

  EditProfileState copyWith({
    BaseState<UserEntity>? profileState,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return EditProfileState(
      profileState: profileState ?? this.profileState,
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [
        profileState,
        successMessage,
      ];
}
