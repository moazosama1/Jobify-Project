import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/constants/const_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SearchLocalDataSource {
  Future<List<String>> getRecentSearches();
  Future<bool> saveRecentSearch(String query);
  Future<void> clearRecentSearches();
}

@LazySingleton(as: SearchLocalDataSource)
class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final SharedPreferences _prefs;

  SearchLocalDataSourceImpl(this._prefs);

  @override
  Future<List<String>> getRecentSearches() async {
    return _prefs.getStringList(ConstKeys.kSearchHistory) ?? const [];
  }

  @override
  Future<bool> saveRecentSearch(String query) async {
    if (query.trim().isEmpty) return false;

    final searches = List<String>.from(
      _prefs.getStringList(ConstKeys.kSearchHistory) ?? const [],
    );

    searches.removeWhere((item) => item == query);
    searches.insert(0, query);

    if (searches.length > 10) {
      searches.removeRange(10, searches.length);
    }

    await _prefs.setStringList(ConstKeys.kSearchHistory, searches);

    return true;
  }

  @override
  Future<void> clearRecentSearches() async {
    await _prefs.remove(ConstKeys.kSearchHistory);
  }
}
