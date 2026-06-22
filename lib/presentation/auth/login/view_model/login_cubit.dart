import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/login_entity.dart';
import 'package:jobify_project/domain/entities/login_request_entity.dart';
import 'package:jobify_project/domain/use_cases/login_use_case.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_event.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginState());

  void doIntent(LoginEvent event) {
    if (event is LoginSubmittedEvent) {
      _onLoginSubmitted(event.email, event.password);
    } else if (event is GoogleLoginClickedEvent) {
      _onGoogleLoginClicked();
    } else if (event is ToggleRememberMeEvent) {
      _onToggleRememberMe(event.value);
    }
  }

  void _onToggleRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  Future<void> _onLoginSubmitted(String email, String password) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    
    final result = await _loginUseCase.call(
      LoginRequestEntity(email: email, password: password),
    );

    if (result is ApiSuccessResult<LoginEntity>) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        data: result.data,
      ));
    } else if (result is ApiErrorResult<LoginEntity>) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.errorMessage,
      ));
    }
  }

  Future<void> _onGoogleLoginClicked() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      // Setup mocked network delay
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
