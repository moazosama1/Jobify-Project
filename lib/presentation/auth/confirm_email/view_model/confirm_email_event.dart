import 'package:equatable/equatable.dart';

sealed class ConfirmEmailEvent extends Equatable {
  const ConfirmEmailEvent();

  @override
  List<Object?> get props => [];
}

class ConfirmEmailSubmittedEvent extends ConfirmEmailEvent {
  final String email;
  final String otp;

  const ConfirmEmailSubmittedEvent({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}
