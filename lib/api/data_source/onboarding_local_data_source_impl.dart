import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/constants/const_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jobify_project/data/data_source/onboarding_local_data_source.dart';

@Injectable(as: OnboardingLocalDataSource)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences _prefs;

  OnboardingLocalDataSourceImpl(this._prefs);

  @override
  Future<void> saveOnboardingStatus(bool completed) async {
    // await _prefs.setBool(ConstKeys.onboardingKey, completed);
  }

  @override
  Future<bool> getOnboardingStatus() async {
    return _prefs.getBool(ConstKeys.onboardingKey) ?? false;
  }
}
