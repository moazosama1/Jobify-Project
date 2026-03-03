import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/domain/use_cases/get_onboarding_status_use_case.dart';

import 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final GetOnboardingStatusUseCase _getOnboardingStatusUseCase;

  SplashCubit(this._getOnboardingStatusUseCase) : super(SplashInitial()) {
    onSplashStartedEvent();
  }

  void onSplashStartedEvent() async {
    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    final bool isOnboardingCompleted = await _getOnboardingStatusUseCase();
    if (isOnboardingCompleted) {
      emit(SplashNavigateToHome());
    } else {
      emit(SplashNavigateToOnboarding());
    }
  }
}
