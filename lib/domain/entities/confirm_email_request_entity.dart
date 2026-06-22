import 'package:equatable/equatable.dart';

class ConfirmEmailRequestEntity extends Equatable {
  final String email;
  final String otp;

  const ConfirmEmailRequestEntity({
    required this.email,
    required this.otp,
  });

  @override
  List<Object?> get props => [email, otp];
}
