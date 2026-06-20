import 'package:injectable/injectable.dart' hide Order;
import 'package:jobify_project/data/models/recent_search_model.dart';
import 'package:jobify_project/objectbox.g.dart';

abstract class SearchLocalDataSource {
  Future<List<String>> getRecentSearches();
  Future<bool> saveRecentSearch(String query);
  Future<void> clearRecentSearches();
}

@LazySingleton(as: SearchLocalDataSource)
class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final Box<RecentSearchModel> _searchBox;

  SearchLocalDataSourceImpl(Store store)
    : _searchBox = store.box<RecentSearchModel>();

  @override
  Future<List<String>> getRecentSearches() async {
    final query = _searchBox
        .query()
        .order(RecentSearchModel_.id, flags: Order.descending)
        .build();
    final results = query.find();
    query.close();

    return results.map((e) => e.query).toList();
  }

  @override
  Future<bool> saveRecentSearch(String query) async {
    if (query.trim().isEmpty) return false;

    // Check if it already exists
    final existQuery = _searchBox
        .query(RecentSearchModel_.query.equals(query))
        .build();
    final existingSearches = existQuery.find();
    existQuery.close();

    if (existingSearches.isNotEmpty) {
      // Remove to put at top again
      for (var item in existingSearches) {
        _searchBox.remove(item.id);
      }
    }

    _searchBox.put(RecentSearchModel(query: query));

    // Keep only last 10 entries
    if (_searchBox.count() > 10) {
      final oldQuery = _searchBox.query().order(RecentSearchModel_.id).build();
      final oldestItems = oldQuery.find();
      oldQuery.close();

      final diff = oldestItems.length - 10;
      for (int i = 0; i < diff; i++) {
        _searchBox.remove(oldestItems[i].id);
      }
    }

    return true;
  }

  @override
  Future<void> clearRecentSearches() async {
    _searchBox.removeAll();
  }
}
