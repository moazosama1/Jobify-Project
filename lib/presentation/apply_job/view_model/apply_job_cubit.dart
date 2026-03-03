import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jobify_project/core/api_result/base_state.dart';

import 'apply_job_event.dart';
import 'apply_job_state.dart';

@injectable
class ApplyJobCubit extends Cubit<ApplyJobState> {
  ApplyJobCubit() : super(const ApplyJobState());

  void doIntent(ApplyJobEvent event) {
    if (event is CvFilePickedEvent) {
      _onCvFilePicked(event.cvFile);
    } else if (event is SubmitJobApplicationEvent) {
      _submitJobApplication(
        fullName: event.fullName,
        portfolioUrl: event.portfolioUrl,
        motivationalLetter: event.motivationalLetter,
      );
    }
  }

  void _onCvFilePicked(PlatformFile cvFile) {
    emit(state.copyWith(selectedCv: cvFile));
  }

  Future<void> _submitJobApplication({
    required String fullName,
    required String portfolioUrl,
    required String motivationalLetter,
  }) async {
    emit(
      state.copyWith(
        fullName: fullName,
        portfolioUrl: portfolioUrl,
        motivationalLetter: motivationalLetter,
        apiStatus: BaseState.loading(),
      ),
    );

    // Simulate API call for applying locally
    await Future.delayed(const Duration(seconds: 2));

    if (state.fullName.isEmpty ||
        state.portfolioUrl.isEmpty ||
        state.selectedCv == null) {
      emit(
        state.copyWith(
          // apiStatus: BaseState.error(
          //   "Please fill in all required fields and upload your CV.",
          // ),
          apiStatus: BaseState.success(true),
        ),
      );
      return;
    }

    emit(state.copyWith(apiStatus: BaseState.success(true)));
  }
}
