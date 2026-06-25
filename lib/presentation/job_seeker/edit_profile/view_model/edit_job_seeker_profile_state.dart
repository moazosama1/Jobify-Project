import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';

class EditJobSeekerProfileState extends BaseState<UserEntity> {
  final String? successMessage;

  const EditJobSeekerProfileState({
    super.isLoading = false,
    super.errorMessage,
    super.data,
    this.successMessage,
  });

  EditJobSeekerProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserEntity? data,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return EditJobSeekerProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        successMessage,
        data,
      ];
}
