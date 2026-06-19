import 'package:equatable/equatable.dart';

class ResetPasswordEntity extends Equatable {
  final String message;

  const ResetPasswordEntity({required this.message});

  @override
  List<Object?> get props => [message];
}
