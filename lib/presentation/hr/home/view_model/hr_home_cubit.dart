import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/domain/entities/category_entity.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/domain/use_cases/get_my_jobs_use_case.dart';
import 'package:jobify_project/domain/use_cases/delete_job_use_case.dart';
import 'hr_home_event.dart';
import 'hr_home_state.dart';

@injectable
class HrHomeCubit extends Cubit<HrHomeState> {
  final GetMyJobsUseCase _getMyJobsUseCase;
  final DeleteJobUseCase _deleteJobUseCase;

  HrHomeCubit(
    this._getMyJobsUseCase,
    this._deleteJobUseCase,
  ) : super(const HrHomeState());

  void doIntent(HrHomeEvent event) {
    switch (event) {
      case LoadHrHomeEvent():
        _onLoadData();
        break;
      case final ToggleBookmarkHrHomeEvent toggleEvent:
        _onToggleBookmark(toggleEvent.jobId);
        break;
      case final DeleteJobHrHomeEvent deleteEvent:
        _onDeleteJob(deleteEvent.jobId);
        break;
    }
  }

  Future<void> _onLoadData() async {
    emit(state.copyWith(isLoading: true, clearError: true));

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

    final mockSuggestedJobs = [
      const JobEntity(
        id: 's1',
        companyName: 'Google LLC',
        logoAsset: 'assets/icons/google.png',
        title: 'Sr. UX Designer',
        salary: '\$195,000',
        tags: ['Design', 'Full Time', 'In House'],
        location: 'In House',
        isBookmarked: false,
      ),
      const JobEntity(
        id: 's2',
        companyName: 'Facebook Inc.',
        logoAsset: 'assets/icons/facebook.png',
        title: 'Lead Engineer',
        salary: '\$190,000',
        tags: ['Design', 'Full Time', 'Remote'],
        location: 'Remote',
        isBookmarked: true,
      ),
    ];

    final result = await _getMyJobsUseCase();

    switch (result) {
      case ApiSuccessResult(:final data):
        emit(
          state.copyWith(
            isLoading: false,
            categories: mockCategories,
            suggestedJobs: mockSuggestedJobs,
            recentJobs: data,
          ),
        );
        break;
      case ApiErrorResult(:final error):
        emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
        break;
    }
  }

  void _onToggleBookmark(String jobId) {
    final updatedSuggested = state.suggestedJobs.map((job) {
      if (job.id == jobId) {
        return job.copyWith(isBookmarked: !job.isBookmarked);
      }
      return job;
    }).toList();

    final updatedRecent = state.recentJobs.map((job) {
      if (job.id == jobId) {
        return job.copyWith(isBookmarked: !job.isBookmarked);
      }
      return job;
    }).toList();

    emit(
      state.copyWith(
        suggestedJobs: updatedSuggested,
        recentJobs: updatedRecent,
      ),
    );
  }

  Future<void> _onDeleteJob(String jobId) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteJobUseCase(jobId);
    switch (result) {
      case ApiSuccessResult():
        _onLoadData();
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
