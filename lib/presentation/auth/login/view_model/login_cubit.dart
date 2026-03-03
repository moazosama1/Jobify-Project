import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_event.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

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
    try {
      // Setup mocked network delay
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
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
