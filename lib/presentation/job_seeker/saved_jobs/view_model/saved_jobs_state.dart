import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class SavedJobsState extends BaseState {
  final List<JobEntity> savedJobs;
  final List<JobEntity> filteredJobs;
  final String searchQuery;
  final String? actionMessage;
  final bool isActionSuccess;

  const SavedJobsState({
    super.isLoading = false,
    super.errorMessage = '',
    this.savedJobs = const [],
    this.filteredJobs = const [],
    this.searchQuery = '',
    this.actionMessage,
    this.isActionSuccess = false,
  });

  SavedJobsState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<JobEntity>? savedJobs,
    List<JobEntity>? filteredJobs,
    String? searchQuery,
    String? actionMessage,
    bool? isActionSuccess,
    bool clearActionMessage = false,
  }) {
    return SavedJobsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      savedJobs: savedJobs ?? this.savedJobs,
      filteredJobs: filteredJobs ?? this.filteredJobs,
      searchQuery: searchQuery ?? this.searchQuery,
      actionMessage: clearActionMessage ? null : (actionMessage ?? this.actionMessage),
      isActionSuccess: isActionSuccess ?? this.isActionSuccess,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    savedJobs,
    filteredJobs,
    searchQuery,
    actionMessage,
    isActionSuccess,
  ];
}
