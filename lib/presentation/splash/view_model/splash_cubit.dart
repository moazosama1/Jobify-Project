import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/domain/use_cases/get_onboarding_status_use_case.dart';
import 'package:jobify_project/domain/use_cases/get_stored_user_role_use_case.dart';

import 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final GetOnboardingStatusUseCase _getOnboardingStatusUseCase;
  final GetStoredUserRoleUseCase _getStoredUserRoleUseCase;

  SplashCubit(
    this._getOnboardingStatusUseCase,
    this._getStoredUserRoleUseCase,
  ) : super(SplashInitial()) {
    onSplashStartedEvent();
  }

  void onSplashStartedEvent() async {
    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    final bool isOnboardingCompleted = await _getOnboardingStatusUseCase();
    if (isOnboardingCompleted) {
      final role = await _getStoredUserRoleUseCase();
      if (role == null) {
        emit(SplashNavigateToLogin());
      } else if (role == 'admin') {
        emit(SplashNavigateToHrHome());
      } else {
        emit(SplashNavigateToHome());
      }
    } else {
      emit(SplashNavigateToOnboarding());
    }
  }
}
