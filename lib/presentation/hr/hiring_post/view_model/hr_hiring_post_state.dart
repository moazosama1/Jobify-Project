import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/create_job_response_entity.dart';

class HrHiringPostState extends Equatable {
  final BaseState<CreateJobResponseEntity> createJobStatus;

  const HrHiringPostState({
    this.createJobStatus = const BaseState<CreateJobResponseEntity>(),
  });

  HrHiringPostState copyWith({
    BaseState<CreateJobResponseEntity>? createJobStatus,
  }) {
    return HrHiringPostState(
      createJobStatus: createJobStatus ?? this.createJobStatus,
    );
  }

  @override
  List<Object?> get props => [createJobStatus];
}
