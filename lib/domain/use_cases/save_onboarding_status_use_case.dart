import 'package:injectable/injectable.dart';
import 'package:jobify_project/domain/repo/onboarding_repo.dart';

@injectable
class SaveOnboardingStatusUseCase {
  final OnboardingRepo _repo;

  SaveOnboardingStatusUseCase(this._repo);

  Future<void> call({required bool completed}) async {
    return await _repo.saveOnboardingStatus(completed);
  }
}
