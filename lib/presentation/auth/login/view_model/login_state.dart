class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final bool rememberMe;

  const LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.rememberMe = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool? rememberMe,
    bool clearError = false,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isSuccess: isSuccess ?? this.isSuccess,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
