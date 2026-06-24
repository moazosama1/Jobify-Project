import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/domain/entities/category_entity.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/domain/entities/get_all_jobs_response_entity.dart';
import 'package:jobify_project/domain/use_cases/get_all_jobs_use_case.dart';
import 'package:jobify_project/domain/use_cases/remove_saved_job_use_case.dart';
import 'package:jobify_project/domain/use_cases/save_job_use_case.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_event.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetAllJobsUseCase _getAllJobsUseCase;
  final SaveJobUseCase _saveJobUseCase;
  final RemoveSavedJobUseCase _removeSavedJobUseCase;

  HomeCubit(
    this._getAllJobsUseCase,
    this._saveJobUseCase,
    this._removeSavedJobUseCase,
  ) : super(const HomeState()) {
    _init();
  }

  void _init() {
    doIntent(HomeLoadDataEvent());
  }

  void doIntent(HomeEvent event) {
    if (event is HomeLoadDataEvent) {
      _onLoadData();
    } else if (event is HomeToggleBookmarkEvent) {
      _onToggleBookmark(event.jobId);
    } else if (event is HomeUpdateFiltersEvent) {
      _onUpdateFilters(event.filters);
    }
  }

  void _onUpdateFilters(GetAllJobsRequestEntity filters) {
    emit(state.copyWith(activeFilters: filters));
    doIntent(HomeLoadDataEvent());
  }

  Future<void> _onLoadData() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final mockCategories = [
        const CategoryEntity(
          id: '1',
          nameKey: 'categoryCompany',
          icon: AppImages.iconCompany,
        ),
        const CategoryEntity(
          id: '2',
          nameKey: 'categoryFullTime',
          icon: AppImages.iconFullTime,
        ),
        const CategoryEntity(
          id: '3',
          nameKey: 'categoryPartTime',
          icon: AppImages.iconPartTime,
        ),
        const CategoryEntity(
          id: '4',
          nameKey: 'categoryFreelance',
          icon: AppImages.iconFreelance,
        ),
      ];

      final request = state.activeFilters ?? const GetAllJobsRequestEntity();
      final result = await _getAllJobsUseCase.call(request);

      if (result is ApiSuccessResult<GetAllJobsResponseEntity>) {
        final jobs = result.data.jobs;
        // Show all jobs in recent jobs, and up to 5 jobs in suggested jobs
        final suggestedJobs = jobs.take(5).toList();
        final recentJobs = List<JobEntity>.from(jobs);

        emit(
          state.copyWith(
            isLoading: false,
            categories: mockCategories,
            suggestedJobs: suggestedJobs,
            recentJobs: recentJobs,
          ),
        );
      } else if (result is ApiErrorResult<GetAllJobsResponseEntity>) {
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onToggleBookmark(String jobId) async {
    // Determine the current bookmark status
    bool wasBookmarked = false;
    final suggestedJob = state.suggestedJobs
        .where((j) => j.id == jobId)
        .firstOrNull;
    final recentJob = state.recentJobs.where((j) => j.id == jobId).firstOrNull;

    if (suggestedJob != null) {
      wasBookmarked = suggestedJob.isBookmarked;
    } else if (recentJob != null) {
      wasBookmarked = recentJob.isBookmarked;
    }

    // Map suggested jobs list
    final updatedSuggested = state.suggestedJobs.map((job) {
      if (job.id == jobId) {
        return job.copyWith(isBookmarked: !job.isBookmarked);
      }
      return job;
    }).toList();

    // Map recent jobs list
    final updatedRecent = state.recentJobs.map((job) {
      if (job.id == jobId) {
        return job.copyWith(isBookmarked: !job.isBookmarked);
      }
      return job;
    }).toList();

    // Optimistically emit state
    emit(
      state.copyWith(
        suggestedJobs: updatedSuggested,
        recentJobs: updatedRecent,
        clearActionMessage: true,
      ),
    );

    // Call API
    ApiResult<String> result;
    if (wasBookmarked) {
      result = await _removeSavedJobUseCase(jobId);
    } else {
      result = await _saveJobUseCase(jobId);
    }

    if (result is ApiSuccessResult<String>) {
      emit(state.copyWith(actionMessage: result.data, isActionSuccess: true));
    } else if (result is ApiErrorResult<String>) {
      // Revert optimistic update
      final revertedSuggested = state.suggestedJobs.map((job) {
        if (job.id == jobId) {
          return job.copyWith(isBookmarked: wasBookmarked);
        }
        return job;
      }).toList();

      final revertedRecent = state.recentJobs.map((job) {
        if (job.id == jobId) {
          return job.copyWith(isBookmarked: wasBookmarked);
        }
        return job;
      }).toList();

      emit(
        state.copyWith(
          suggestedJobs: revertedSuggested,
          recentJobs: revertedRecent,
          actionMessage: result.errorMessage,
          isActionSuccess: false,
        ),
      );
    }
  }
}
