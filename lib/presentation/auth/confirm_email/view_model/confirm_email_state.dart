import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/confirm_email_entity.dart';

class ConfirmEmailState extends Equatable {
  final BaseState<ConfirmEmailEntity> confirmEmailStatus;

  const ConfirmEmailState({
    this.confirmEmailStatus = const BaseState<ConfirmEmailEntity>(),
  });

  ConfirmEmailState copyWith({
    BaseState<ConfirmEmailEntity>? confirmEmailStatus,
  }) {
    return ConfirmEmailState(
      confirmEmailStatus: confirmEmailStatus ?? this.confirmEmailStatus,
    );
  }

  @override
  List<Object?> get props => [confirmEmailStatus];
}
