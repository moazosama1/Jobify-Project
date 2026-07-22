import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/create_job_response_entity.dart';

class HrHiringPostState extends Equatable {
  final BaseState<CreateJobResponseEntity> createJobStatus;
  final String? userProfileImage;

  const HrHiringPostState({
    this.createJobStatus = const BaseState<CreateJobResponseEntity>(),
    this.userProfileImage,
  });

  HrHiringPostState copyWith({
    BaseState<CreateJobResponseEntity>? createJobStatus,
    String? userProfileImage,
  }) {
    return HrHiringPostState(
      createJobStatus: createJobStatus ?? this.createJobStatus,
      userProfileImage: userProfileImage ?? this.userProfileImage,
    );
  }

  @override
  List<Object?> get props => [createJobStatus, userProfileImage];
}
