import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/category_entity.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class HrHomeState extends BaseState<dynamic> {
  final List<CategoryEntity> categories;
  final List<JobEntity> suggestedJobs;
  final List<JobEntity> recentJobs;

  final String searchQuery;

  const HrHomeState({
    super.isLoading = false,
    super.errorMessage,
    this.categories = const [],
    this.suggestedJobs = const [],
    this.recentJobs = const [],
    this.searchQuery = '',
  });

  List<JobEntity> get filteredSuggestedJobs {
    if (searchQuery.isEmpty) return suggestedJobs;
    return suggestedJobs.where((job) => job.title.toLowerCase().contains(searchQuery.toLowerCase()) || job.companyName.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  List<JobEntity> get filteredRecentJobs {
    if (searchQuery.isEmpty) return recentJobs;
    return recentJobs.where((job) => job.title.toLowerCase().contains(searchQuery.toLowerCase()) || job.companyName.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  HrHomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<CategoryEntity>? categories,
    List<JobEntity>? suggestedJobs,
    List<JobEntity>? recentJobs,
    String? searchQuery,
    bool clearError = false,
  }) {
    return HrHomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      categories: categories ?? this.categories,
      suggestedJobs: suggestedJobs ?? this.suggestedJobs,
      recentJobs: recentJobs ?? this.recentJobs,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    categories,
    suggestedJobs,
    recentJobs,
    searchQuery,
  ];
}
