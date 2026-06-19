import 'package:equatable/equatable.dart';

class ConfirmEmailEntity extends Equatable {
  final String message;

  const ConfirmEmailEntity({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
