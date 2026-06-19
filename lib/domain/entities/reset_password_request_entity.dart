import 'package:equatable/equatable.dart';

class ResetPasswordRequestEntity extends Equatable {
  final String email;
  final String otp;
  final String password;
  final String cPassword;

  const ResetPasswordRequestEntity({
    required this.email,
    required this.otp,
    required this.password,
    required this.cPassword,
  });

  @override
  List<Object?> get props => [email, otp, password, cPassword];
}
