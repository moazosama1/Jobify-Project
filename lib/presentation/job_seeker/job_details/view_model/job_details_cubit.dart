import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/get_job_by_id_response_entity.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/domain/use_cases/get_job_by_id_use_case.dart';
import 'package:jobify_project/domain/use_cases/remove_saved_job_use_case.dart';
import 'package:jobify_project/domain/use_cases/save_job_use_case.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view_model/job_details_event.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view_model/job_details_state.dart';

@injectable
class JobDetailsCubit extends Cubit<JobDetailsState> {
  final SaveJobUseCase _saveJobUseCase;
  final RemoveSavedJobUseCase _removeSavedJobUseCase;
  final GetJobByIdUseCase _getJobByIdUseCase;

  JobDetailsCubit(
    @factoryParam JobEntity? initialJob,
    this._saveJobUseCase,
    this._removeSavedJobUseCase,
    this._getJobByIdUseCase,
  ) : super(JobDetailsState(
          jobDetails: initialJob != null
              ? BaseState<JobEntity>.success(initialJob)
              : const BaseState<JobEntity>(),
        )) {
    _init();
  }

  void _init() {
    doIntent(LoadJobDetailsEvent());
  }

  void doIntent(JobDetailsEvent event) {
    if (event is LoadJobDetailsEvent) {
      _onLoadData();
    } else if (event is ToggleSavedJobDetailsEvent) {
      _onToggleBookmark(event.jobId);
    }
  }

  Future<void> _onLoadData() async {
    final currentJobId = state.jobDetails.data?.id;
    if (currentJobId == null) return;

    emit(state.copyWith(jobDetails: BaseState<JobEntity>.loading()));

    final result = await _getJobByIdUseCase(currentJobId);
    
    if (result is ApiSuccessResult<GetJobByIdResponseEntity>) {
      if (result.data.job != null) {
        emit(state.copyWith(
          jobDetails: BaseState<JobEntity>.success(result.data.job!),
        ));
      } else {
        emit(state.copyWith(
          jobDetails: BaseState<JobEntity>.error('Job not found'),
        ));
      }
    } else if (result is ApiErrorResult<GetJobByIdResponseEntity>) {
      emit(state.copyWith(
        jobDetails: BaseState<JobEntity>.error(result.errorMessage),
      ));
    }
  }

  Future<void> _onToggleBookmark(String jobId) async {
    final currentJob = state.jobDetails.data;
    if (currentJob == null) return;

    final wasBookmarked = currentJob.isBookmarked;

    // Optimistic UI update
    emit(state.copyWith(
      jobDetails: BaseState<JobEntity>.success(
        currentJob.copyWith(isBookmarked: !wasBookmarked),
      ),
      clearActionMessage: true,
    ));

    ApiResult<String> result;
    if (wasBookmarked) {
      result = await _removeSavedJobUseCase(jobId);
    } else {
      result = await _saveJobUseCase(jobId);
    }

    if (result is ApiSuccessResult<String>) {
      emit(state.copyWith(
        actionMessage: result.data,
        isActionSuccess: true,
      ));
    } else if (result is ApiErrorResult<String>) {
      // Revert optimistic update
      emit(state.copyWith(
        jobDetails: BaseState<JobEntity>.success(
          currentJob.copyWith(isBookmarked: wasBookmarked),
        ),
        actionMessage: result.errorMessage,
        isActionSuccess: false,
      ));
    }
  }
}
