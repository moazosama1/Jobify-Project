import 'package:injectable/injectable.dart';
import 'package:jobify_project/data/data_source/onboarding_local_data_source.dart';
import 'package:jobify_project/domain/repo/onboarding_repo.dart';

@Injectable(as: OnboardingRepo)
class OnboardingRepoImpl implements OnboardingRepo {
  final OnboardingLocalDataSource _localDataSource;

  OnboardingRepoImpl(this._localDataSource);

  @override
  Future<void> saveOnboardingStatus(bool completed) async {
    return await _localDataSource.saveOnboardingStatus(completed);
  }

  @override
  Future<bool> getOnboardingStatus() async {
    return await _localDataSource.getOnboardingStatus();
  }
}
