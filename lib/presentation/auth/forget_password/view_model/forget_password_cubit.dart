import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_event.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(const ForgetPasswordState());

  void doIntent(ForgetPasswordEvent event) {
    if (event is SendEmailCodeEvent) {
      _sendEmailCode(event.email);
    } else if (event is VerifyOtpEvent) {
      _verifyOtp(event.code);
    } else if (event is ResendOtpEvent) {
      _resendOtp();
    } else if (event is ResetPasswordSubmittedEvent) {
      _resetPassword(event.newPassword, event.confirmPassword);
    } else if (event is BackToPreviousStepEvent) {
      _backToPreviousStep();
    }
  }

  Future<void> _sendEmailCode(String email) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(
        state.copyWith(
          isLoading: false,
          currentStep: 1, // Move to OTP step
          email: email, // Save email for next step
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _verifyOtp(String code) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (code == "4910") {
        // Mock condition for the UI mockup
        emit(
          state.copyWith(
            isLoading: false,
            currentStep: 2, // Move to New Password step
            otpCode: code,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            currentStep: 2, // Proceed anyway for testing purposes if not 4910
            otpCode: code,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _resendOtp() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isLoading: false, isSuccess: false));
      // Just simulate success of sending, no step change
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _resetPassword(
    String newPassword,
    String confirmPassword,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _backToPreviousStep() {
    if (state.currentStep > 0) {
      emit(
        state.copyWith(currentStep: state.currentStep - 1, clearError: true),
      );
    }
  }
}
