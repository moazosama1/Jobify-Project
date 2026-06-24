import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

class JobDetailsState extends Equatable {
  final BaseState<JobEntity> jobDetails;
  final String? actionMessage;
  final bool isActionSuccess;

  const JobDetailsState({
    this.jobDetails = const BaseState<JobEntity>(),
    this.actionMessage,
    this.isActionSuccess = false,
  });

  JobDetailsState copyWith({
    BaseState<JobEntity>? jobDetails,
    String? actionMessage,
    bool? isActionSuccess,
    bool clearActionMessage = false,
  }) {
    return JobDetailsState(
      jobDetails: jobDetails ?? this.jobDetails,
      actionMessage: clearActionMessage ? null : (actionMessage ?? this.actionMessage),
      isActionSuccess: isActionSuccess ?? this.isActionSuccess,
    );
  }

  @override
  List<Object?> get props => [
        jobDetails,
        actionMessage,
        isActionSuccess,
      ];
}
