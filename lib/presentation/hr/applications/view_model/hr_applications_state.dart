import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class HrApplicationsState extends BaseState<dynamic> {
  final List<JobEntity> jobs;

  const HrApplicationsState({
    super.isLoading = false,
    super.errorMessage,
    this.jobs = const [],
  });

  HrApplicationsState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<JobEntity>? jobs,
    bool clearError = false,
  }) {
    return HrApplicationsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      jobs: jobs ?? this.jobs,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        jobs,
      ];
}
