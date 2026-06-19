import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/forget_password_entity.dart';
import 'package:jobify_project/domain/entities/forget_password_request_entity.dart';
import 'package:jobify_project/domain/entities/reset_password_entity.dart';
import 'package:jobify_project/domain/entities/reset_password_request_entity.dart';
import 'package:jobify_project/domain/use_cases/forget_password_use_case.dart';
import 'package:jobify_project/domain/use_cases/reset_password_use_case.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_event.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetPasswordCubit(
    this._forgetPasswordUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgetPasswordState());

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
    
    final result = await _forgetPasswordUseCase.call(
      ForgetPasswordRequestEntity(email: email),
    );

    if (result is ApiSuccessResult<ForgetPasswordEntity>) {
      emit(
        state.copyWith(
          isLoading: false,
          currentStep: 1, // Move to OTP step
          email: email, // Save email for next step
        ),
      );
    } else if (result is ApiErrorResult<ForgetPasswordEntity>) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.errorMessage,
      ));
    }
  }

  Future<void> _verifyOtp(String code) async {
    emit(state.copyWith(
      currentStep: 2, // Move to New Password step
      otpCode: code,
    ));
  }

  Future<void> _resendOtp() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    
    final result = await _forgetPasswordUseCase.call(
      ForgetPasswordRequestEntity(email: state.email),
    );

    if (result is ApiSuccessResult<ForgetPasswordEntity>) {
      emit(state.copyWith(isLoading: false));
    } else if (result is ApiErrorResult<ForgetPasswordEntity>) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.errorMessage,
      ));
    }
  }

  Future<void> _resetPassword(
    String newPassword,
    String confirmPassword,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    
    final result = await _resetPasswordUseCase.call(
      ResetPasswordRequestEntity(
        email: state.email,
        otp: state.otpCode,
        password: newPassword,
        cPassword: confirmPassword,
      ),
    );

    if (result is ApiSuccessResult<ResetPasswordEntity>) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } else if (result is ApiErrorResult<ResetPasswordEntity>) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.errorMessage,
      ));
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
