import 'package:jobify_project/core/api_result/base_state.dart';

class SearchState extends BaseState<bool> {
  final List<String> recentSearches;

  const SearchState({
    super.isLoading,
    super.errorMessage,
    super.data,
    this.recentSearches = const [],
  });

  SearchState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? data,
    List<String>? recentSearches,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }

  @override
  List<Object?> get props => super.props + [recentSearches];
}
