import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/domain/use_cases/get_saved_jobs_use_case.dart';
import 'package:jobify_project/domain/use_cases/remove_saved_job_use_case.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view_model/saved_jobs_event.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view_model/saved_jobs_state.dart';

@injectable
class SavedJobsCubit extends Cubit<SavedJobsState> {
  final GetSavedJobsUseCase _getSavedJobsUseCase;
  final RemoveSavedJobUseCase _removeSavedJobUseCase;

  SavedJobsCubit(
    this._getSavedJobsUseCase,
    this._removeSavedJobUseCase,
  ) : super(const SavedJobsState()) {
    _init();
  }

  void _init() {
    doIntent(SavedJobsLoadEvent());
  }

  void doIntent(SavedJobsEvent event) {
    if (event is SavedJobsLoadEvent) {
      _onLoadJobs();
    } else if (event is SavedJobsRemoveEvent) {
      _onRemoveJob(event.jobId);
    } else if (event is SavedJobsSearchEvent) {
      _onSearch(event.query);
    }
  }

  Future<void> _onLoadJobs() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final result = await _getSavedJobsUseCase();

    if (result is ApiSuccessResult<List<JobEntity>>) {
      emit(
        state.copyWith(
          isLoading: false,
          savedJobs: result.data,
          filteredJobs: _filterJobs(result.data, state.searchQuery),
        ),
      );
    } else if (result is ApiErrorResult<List<JobEntity>>) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: result.errorMessage,
        ),
      );
    }
  }

  Future<void> _onRemoveJob(String jobId) async {
    // Optimistic update
    final previousJobs = List<JobEntity>.from(state.savedJobs);
    final updatedList = state.savedJobs.where((job) => job.id != jobId).toList();
    emit(
      state.copyWith(
        savedJobs: updatedList,
        filteredJobs: _filterJobs(updatedList, state.searchQuery),
        clearActionMessage: true,
      ),
    );

    final result = await _removeSavedJobUseCase(jobId);

    if (result is ApiSuccessResult<String>) {
      emit(state.copyWith(
        actionMessage: result.data,
        isActionSuccess: true,
      ));
    } else if (result is ApiErrorResult<String>) {
      // Revert if error without calling the API again
      emit(state.copyWith(
        savedJobs: previousJobs,
        filteredJobs: _filterJobs(previousJobs, state.searchQuery),
        actionMessage: result.errorMessage,
        isActionSuccess: false,
      ));
    }
  }

  void _onSearch(String query) {
    emit(
      state.copyWith(
        searchQuery: query,
        filteredJobs: _filterJobs(state.savedJobs, query),
      ),
    );
  }

  List<JobEntity> _filterJobs(List<JobEntity> jobs, String query) {
    if (query.isEmpty) return jobs;
    final lowerQuery = query.toLowerCase();
    return jobs.where((job) {
      return job.title.toLowerCase().contains(lowerQuery) ||
          job.companyName.toLowerCase().contains(lowerQuery) ||
          job.location.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
