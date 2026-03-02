abstract class OnboardingRepo {
  Future<void> saveOnboardingStatus(bool completed);
  Future<bool> getOnboardingStatus();
}
