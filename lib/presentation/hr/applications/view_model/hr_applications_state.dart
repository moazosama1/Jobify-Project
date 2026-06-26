import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class HrApplicationsState extends BaseState<dynamic> {
  final List<JobEntity> jobs;
  final List<JobEntity> filteredJobs;
  final String searchQuery;

  const HrApplicationsState({
    super.isLoading = false,
    super.errorMessage,
    this.jobs = const [],
    this.filteredJobs = const [],
    this.searchQuery = '',
  });

  HrApplicationsState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<JobEntity>? jobs,
    List<JobEntity>? filteredJobs,
    String? searchQuery,
    bool clearError = false,
  }) {
    return HrApplicationsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      jobs: jobs ?? this.jobs,
      filteredJobs: filteredJobs ?? this.filteredJobs,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        jobs,
        filteredJobs,
        searchQuery,
      ];
}
