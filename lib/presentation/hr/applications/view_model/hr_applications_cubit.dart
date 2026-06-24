import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/use_cases/get_my_jobs_use_case.dart';
import 'hr_applications_event.dart';
import 'hr_applications_state.dart';

@injectable
class HrApplicationsCubit extends Cubit<HrApplicationsState> {
  final GetMyJobsUseCase _getMyJobsUseCase;

  HrApplicationsCubit(this._getMyJobsUseCase) : super(const HrApplicationsState()) {
    _init();
  }

  void _init() {
    doIntent(const LoadHrApplicationsEvent());
  }

  void doIntent(HrApplicationsEvent event) {
    switch (event) {
      case LoadHrApplicationsEvent():
        _onLoadJobs();
        break;
    }
  }

  Future<void> _onLoadJobs() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await _getMyJobsUseCase();
    switch (result) {
      case ApiSuccessResult(:final data):
        emit(state.copyWith(
          isLoading: false,
          jobs: data,
        ));
        break;
      case ApiErrorResult(:final error):
        emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        ));
        break;
    }
  }
}
