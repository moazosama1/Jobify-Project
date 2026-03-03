import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class SendEmailCodeEvent extends ForgetPasswordEvent {
  final String email;

  const SendEmailCodeEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class VerifyOtpEvent extends ForgetPasswordEvent {
  final String code;

  const VerifyOtpEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class ResendOtpEvent extends ForgetPasswordEvent {}

class ResetPasswordSubmittedEvent extends ForgetPasswordEvent {
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordSubmittedEvent({
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [newPassword, confirmPassword];
}

class BackToPreviousStepEvent extends ForgetPasswordEvent {}
