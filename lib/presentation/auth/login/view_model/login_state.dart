import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/login_entity.dart';

class LoginState extends BaseState<LoginEntity> {
  final bool isSuccess;
  final bool rememberMe;

  const LoginState({
    super.isLoading = false,
    super.errorMessage,
    super.data,
    this.isSuccess = false,
    this.rememberMe = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    LoginEntity? data,
    bool? isSuccess,
    bool? rememberMe,
    bool clearError = false,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      data: data ?? this.data,
      isSuccess: isSuccess ?? this.isSuccess,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, data, isSuccess, rememberMe];
}
