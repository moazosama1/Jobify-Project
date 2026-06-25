import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/use_cases/apply_job_use_case.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_events.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_state.dart';

@injectable
class ApplyJobCubit extends Cubit<ApplyJobState> {
  final ApplyJobUseCase _applyJobUseCase;

  ApplyJobCubit(this._applyJobUseCase) : super(const ApplyJobState()) {
    _init();
  }

  void _init() {
    // Initial setup if needed
  }

  void doIntent(ApplyJobEvents event) {
    switch (event) {
      case SelectResumeApplyJobEvent():
        _selectResume(event.resumeFilePath);
      case InputCoverLetterApplyJobEvent():
        _inputCoverLetter(event.coverLetter);
      case SubmitApplyJobEvent():
        _submitApplication(event.jobId);
    }
  }

  void _selectResume(String resumeFilePath) {
    emit(state.copyWith(resumeFilePath: resumeFilePath));
  }

  void _inputCoverLetter(String coverLetter) {
    emit(state.copyWith(coverLetter: coverLetter));
  }

  Future<void> _submitApplication(String jobId) async {
    if (state.resumeFilePath == null || state.resumeFilePath!.isEmpty) {
      emit(
        state.copyWith(applyStatus: BaseState.error("Please select a resume")),
      );
      emit(state.copyWith(applyStatus: const BaseState()));
      return;
    }

    if ((state.coverLetter?.trim().length ?? 0) < 20) {
      emit(
        state.copyWith(
          applyStatus: BaseState.error(
            "Cover letter must be at least 20 characters",
          ),
        ),
      );
      emit(state.copyWith(applyStatus: const BaseState()));
      return;
    }

    emit(state.copyWith(applyStatus: BaseState.loading()));

    final result = await _applyJobUseCase(
      jobId: jobId,
      resumeFilePath: state.resumeFilePath!,
      coverLetter: state.coverLetter,
    );

    switch (result) {
      case ApiSuccessResult():
        emit(state.copyWith(applyStatus: BaseState.success(true)));
      case ApiErrorResult():
        String errorMessage = result.errorMessage;
        if (errorMessage.contains('E11000 duplicate key error')) {
          errorMessage = 'You have already applied for this job.';
        }
        emit(state.copyWith(applyStatus: BaseState.error(errorMessage)));
        // Reset to initial to allow retry and clear error
        emit(state.copyWith(applyStatus: const BaseState()));
    }
  }
}
