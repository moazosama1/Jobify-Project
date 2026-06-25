import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/api_result/base_state.dart';

class ApplyJobState extends Equatable {
  final BaseState<bool> applyStatus;
  final String? resumeFilePath;
  final String? coverLetter;

  const ApplyJobState({
    this.applyStatus = const BaseState(),
    this.resumeFilePath,
    this.coverLetter,
  });

  ApplyJobState copyWith({
    BaseState<bool>? applyStatus,
    String? resumeFilePath,
    String? coverLetter,
  }) {
    return ApplyJobState(
      applyStatus: applyStatus ?? this.applyStatus,
      resumeFilePath: resumeFilePath ?? this.resumeFilePath,
      coverLetter: coverLetter ?? this.coverLetter,
    );
  }

  @override
  List<Object?> get props => [applyStatus, resumeFilePath, coverLetter];
}
