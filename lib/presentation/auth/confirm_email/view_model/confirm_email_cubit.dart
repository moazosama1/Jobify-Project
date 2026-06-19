import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/confirm_email_entity.dart';
import 'package:jobify_project/domain/entities/confirm_email_request_entity.dart';
import 'package:jobify_project/domain/use_cases/confirm_email_use_case.dart';
import 'package:jobify_project/presentation/auth/confirm_email/view_model/confirm_email_event.dart';
import 'package:jobify_project/presentation/auth/confirm_email/view_model/confirm_email_state.dart';
import 'package:jobify_project/core/api_result/api_result.dart';

@injectable
class ConfirmEmailCubit extends Cubit<ConfirmEmailState> {
  final ConfirmEmailUseCase _confirmEmailUseCase;

  ConfirmEmailCubit(this._confirmEmailUseCase) : super(const ConfirmEmailState());

  void doIntent(ConfirmEmailEvent event) {
    if (event is ConfirmEmailSubmittedEvent) {
      _onConfirmEmailSubmitted(event.email, event.otp);
    }
  }

  Future<void> _onConfirmEmailSubmitted(String email, String otp) async {
    emit(state.copyWith(confirmEmailStatus: BaseState.loading()));

    final result = await _confirmEmailUseCase.call(
      ConfirmEmailRequestEntity(email: email, otp: otp),
    );

    if (result is ApiSuccessResult<ConfirmEmailEntity>) {
      emit(state.copyWith(
        confirmEmailStatus: BaseState.success(result.data),
      ));
    } else if (result is ApiErrorResult<ConfirmEmailEntity>) {
      emit(state.copyWith(
        confirmEmailStatus: BaseState.error(result.errorMessage),
      ));
    }
  }
}
