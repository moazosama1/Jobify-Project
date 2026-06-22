import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class LoginEntity extends Equatable {
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  const LoginEntity({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  @override
  List<Object?> get props => [message, accessToken, refreshToken, user];
}
