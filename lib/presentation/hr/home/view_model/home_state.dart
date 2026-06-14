import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/category_entity.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class HomeState extends BaseState<dynamic> {
  final List<CategoryEntity> categories;
  final List<JobEntity> suggestedJobs;
  final List<JobEntity> recentJobs;

  const HomeState({
    super.isLoading = false,
    super.errorMessage,
    this.categories = const [],
    this.suggestedJobs = const [],
    this.recentJobs = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<CategoryEntity>? categories,
    List<JobEntity>? suggestedJobs,
    List<JobEntity>? recentJobs,
    bool clearError = false,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      categories: categories ?? this.categories,
      suggestedJobs: suggestedJobs ?? this.suggestedJobs,
      recentJobs: recentJobs ?? this.recentJobs,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    categories,
    suggestedJobs,
    recentJobs,
  ];
}
