import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/presentation/auth/register/view_model/register_event.dart';
import 'package:jobify_project/presentation/auth/register/view_model/register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void doIntent(RegisterEvent event) {
    if (event is RegisterSubmittedEvent) {
      _onRegisterSubmitted(
        event.fullName,
        event.email,
        event.password,
        event.confirmPassword,
      );
    } else if (event is RegisterGoogleLoginClickedEvent) {
      _onGoogleLoginClicked();
    }
  }

  Future<void> _onRegisterSubmitted(
    String fullName,
    String email,
    String password,
    String confirmPassword,
  ) async {
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
