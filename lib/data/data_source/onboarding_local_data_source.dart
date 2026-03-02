abstract interface class OnboardingLocalDataSource {
  Future<void> saveOnboardingStatus(bool completed);
  Future<bool> getOnboardingStatus();
}
