import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/category_entity.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';

class HomeState extends BaseState<dynamic> {
  final List<CategoryEntity> categories;
  final List<JobEntity> suggestedJobs;
  final List<JobEntity> recentJobs;
  final String? actionMessage;
  final bool isActionSuccess;
  final GetAllJobsRequestEntity? activeFilters;

  const HomeState({
    super.isLoading = false,
    super.errorMessage,
    this.categories = const [],
    this.suggestedJobs = const [],
    this.recentJobs = const [],
    this.actionMessage,
    this.isActionSuccess = false,
    this.activeFilters,
  });

  bool get hasActiveFilters {
    if (activeFilters == null) return false;
    return activeFilters!.location != null ||
        activeFilters!.employmentType != null ||
        activeFilters!.isRemote != null ||
        activeFilters!.experienceLevel != null;
  }

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<CategoryEntity>? categories,
    List<JobEntity>? suggestedJobs,
    List<JobEntity>? recentJobs,
    String? actionMessage,
    bool? isActionSuccess,
    GetAllJobsRequestEntity? activeFilters,
    bool clearError = false,
    bool clearActionMessage = false,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      categories: categories ?? this.categories,
      suggestedJobs: suggestedJobs ?? this.suggestedJobs,
      recentJobs: recentJobs ?? this.recentJobs,
      actionMessage: clearActionMessage ? null : (actionMessage ?? this.actionMessage),
      isActionSuccess: isActionSuccess ?? this.isActionSuccess,
      activeFilters: activeFilters ?? this.activeFilters,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    categories,
    suggestedJobs,
    recentJobs,
    actionMessage,
    isActionSuccess,
    activeFilters,
  ];
}
