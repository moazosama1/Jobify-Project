import 'package:injectable/injectable.dart';
import 'package:jobify_project/domain/repo/onboarding_repo.dart';

@injectable
class GetOnboardingStatusUseCase {
  final OnboardingRepo _repo;

  GetOnboardingStatusUseCase(this._repo);

  Future<bool> call() async {
    return await _repo.getOnboardingStatus();
  }
}
