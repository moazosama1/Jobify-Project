import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/domain/use_cases/save_onboarding_status_use_case.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final SaveOnboardingStatusUseCase _saveOnboardingStatusUseCase;

  OnboardingCubit(this._saveOnboardingStatusUseCase)
    : super(const OnboardingState());

  void onPageChanged(OnboardingPageChangedEvent event) {
    emit(state.copyWith(currentPageIndex: event.pageIndex));
  }

  void onNextClicked(OnboardingNextClickedEvent event, int totalPages) async {
    if (state.currentPageIndex < totalPages - 1) {
      emit(state.copyWith(currentPageIndex: state.currentPageIndex + 1));
    } else {
      await _completeOnboarding();
    }
  }

  void onSkipClicked(OnboardingSkipClickedEvent event) async {
    await _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    await _saveOnboardingStatusUseCase(completed: true);
    emit(state.copyWith(isCompleted: true));
  }
}
