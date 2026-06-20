import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/data/data_source/search_local_data_source.dart';
import 'package:jobify_project/domain/repo/search_repository.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource _localDataSource;

  SearchRepositoryImpl(this._localDataSource);

  @override
  Future<ApiResult<List<String>>> getRecentSearches() async {
    try {
      final searches = await _localDataSource.getRecentSearches();
      return ApiSuccessResult(searches);
    } catch (e) {
      return ApiErrorResult(e);
    }
  }

  @override
  Future<ApiResult<bool>> saveRecentSearch(String query) async {
    try {
      final success = await _localDataSource.saveRecentSearch(query);
      return ApiSuccessResult(success);
    } catch (e) {
      return ApiErrorResult(e);
    }
  }

  @override
  Future<ApiResult<bool>> clearRecentSearches() async {
    try {
      await _localDataSource.clearRecentSearches();
      return ApiSuccessResult(true);
    } catch (e) {
      return ApiErrorResult(e);
    }
  }
}
