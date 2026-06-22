import 'package:jobify_project/core/api_result/api_result.dart';

abstract class SearchRepository {
  Future<ApiResult<List<String>>> getRecentSearches();
  Future<ApiResult<bool>> saveRecentSearch(String query);
  Future<ApiResult<bool>> clearRecentSearches();
}
