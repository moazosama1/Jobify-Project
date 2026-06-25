import 'package:equatable/equatable.dart';

class LoginRequestEntity extends Equatable {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginRequestEntity({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}
