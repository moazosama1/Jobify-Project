import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/signup_entity.dart';

class RegisterState extends Equatable {
  final BaseState<SignUpEntity> registerStatus;

  const RegisterState({
    this.registerStatus = const BaseState<SignUpEntity>(),
  });

  RegisterState copyWith({
    BaseState<SignUpEntity>? registerStatus,
  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
    );
  }

  @override
  List<Object?> get props => [registerStatus];
}
