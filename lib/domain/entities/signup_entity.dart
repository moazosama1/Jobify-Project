import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class SignUpEntity extends Equatable {
  final String message;
  final UserEntity? user;

  const SignUpEntity({
    required this.message,
    this.user,
  });

  @override
  List<Object?> get props => [message, user];
}
