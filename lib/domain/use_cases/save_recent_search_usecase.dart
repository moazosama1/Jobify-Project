import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/repo/search_repository.dart';

@injectable
class SaveRecentSearchUseCase {
  final SearchRepository _repository;

  SaveRecentSearchUseCase(this._repository);

  Future<ApiResult<bool>> call(String query) {
    return _repository.saveRecentSearch(query);
  }
}
