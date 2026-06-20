import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/repo/search_repository.dart';

@injectable
class ClearRecentSearchesUseCase {
  final SearchRepository _repository;

  ClearRecentSearchesUseCase(this._repository);

  Future<ApiResult<bool>> call() {
    return _repository.clearRecentSearches();
  }
}
