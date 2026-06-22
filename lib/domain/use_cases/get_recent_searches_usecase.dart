import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/repo/search_repository.dart';

@injectable
class GetRecentSearchesUseCase {
  final SearchRepository _repository;

  GetRecentSearchesUseCase(this._repository);

  Future<ApiResult<List<String>>> call() {
    return _repository.getRecentSearches();
  }
}
