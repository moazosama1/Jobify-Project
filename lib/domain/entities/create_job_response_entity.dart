import 'package:equatable/equatable.dart';

class CreateJobResponseEntity extends Equatable {
  final String message;

  const CreateJobResponseEntity({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
