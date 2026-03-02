abstract class OnboardingEvent {}

class OnboardingPageChangedEvent extends OnboardingEvent {
  final int pageIndex;

  OnboardingPageChangedEvent(this.pageIndex);
}

class OnboardingNextClickedEvent extends OnboardingEvent {}

class OnboardingSkipClickedEvent extends OnboardingEvent {}
