import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/core/enums/gender_enum.dart';
import 'package:jobify_project/core/enums/rule_enum.dart';
import 'package:jobify_project/domain/entities/signup_entity.dart';
import 'package:jobify_project/domain/entities/signup_request_entity.dart';
import 'package:jobify_project/domain/use_cases/signup_use_case.dart';
import 'package:jobify_project/presentation/auth/register/view_model/register_event.dart';
import 'package:jobify_project/presentation/auth/register/view_model/register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final SignUpUseCase _signUpUseCase;

  RegisterCubit(this._signUpUseCase) : super(const RegisterState());

  void doIntent(RegisterEvent event) {
    if (event is RegisterSubmittedEvent) {
      _onRegisterSubmitted(
        firstName: event.firstName,
        lastName: event.lastName,
        age: event.age,
        location: event.location,
        phoneNumber: event.phoneNumber,
        gender: event.gender,
        role: event.role,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        profileImage: event.profileImage,
      );
    } else if (event is RegisterGoogleLoginClickedEvent) {
      _onGoogleLoginClicked();
    }
  }

  Future<void> _onRegisterSubmitted({
    required String firstName,
    required String lastName,
    required String age,
    required String location,
    required String phoneNumber,
    required Gender gender,
    required Rule role,
    required String email,
    required String password,
    required String confirmPassword,
    String? profileImage,
  }) async {
    emit(state.copyWith(registerStatus: BaseState.loading()));

    final result = await _signUpUseCase.call(
      SignUpRequestEntity(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        cPassword: confirmPassword,
        age: int.tryParse(age),
        location: location,
        phoneNumber: phoneNumber,
        gender: gender.name,
        role: role.name,
        profileImage: profileImage,
      ),
    );

    if (result is ApiSuccessResult<SignUpEntity>) {
      emit(state.copyWith(
        registerStatus: BaseState.success(result.data),
      ));
    } else if (result is ApiErrorResult<SignUpEntity>) {
      emit(state.copyWith(
        registerStatus: BaseState.error(result.errorMessage),
      ));
    }
  }

  Future<void> _onGoogleLoginClicked() async {
    emit(state.copyWith(registerStatus: BaseState.loading()));
    try {
      // Setup mocked network delay
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(
        registerStatus: BaseState.success(const SignUpEntity(message: 'Google Sign In Success')),
      ));
    } catch (e) {
      emit(state.copyWith(
        registerStatus: BaseState.error(e.toString()),
      ));
    }
  }
}
