import 'package:equatable/equatable.dart';

class ForgetPasswordState extends Equatable {
  final int currentStep; // 0: Email, 1: OTP, 2: New Password
  final String email;
  final String otpCode;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const ForgetPasswordState({
    this.currentStep = 0,
    this.email = '',
    this.otpCode = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  ForgetPasswordState copyWith({
    int? currentStep,
    String? email,
    String? otpCode,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ForgetPasswordState(
      currentStep: currentStep ?? this.currentStep,
      email: email ?? this.email,
      otpCode: otpCode ?? this.otpCode,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    email,
    otpCode,
    isLoading,
    isSuccess,
    errorMessage,
  ];
}
