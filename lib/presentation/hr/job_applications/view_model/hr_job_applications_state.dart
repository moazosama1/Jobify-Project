import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/job_application_entity.dart';

class HrJobApplicationsState extends BaseState<dynamic> {
  final List<JobApplicationEntity> applications;

  const HrJobApplicationsState({
    super.isLoading = false,
    super.errorMessage,
    this.applications = const [],
  });

  HrJobApplicationsState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<JobApplicationEntity>? applications,
    bool clearError = false,
  }) {
    return HrJobApplicationsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      applications: applications ?? this.applications,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        applications,
      ];
}
