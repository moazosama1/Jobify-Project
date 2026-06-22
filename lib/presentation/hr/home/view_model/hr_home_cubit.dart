import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/domain/entities/category_entity.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'hr_home_event.dart';
import 'hr_home_state.dart';

@injectable
class HrHomeCubit extends Cubit<HrHomeState> {
  HrHomeCubit() : super(const HrHomeState());

  void doIntent(HrHomeEvent event) {
    if (event is HrHomeLoadDataEvent) {
      _onLoadData();
    } else if (event is HrHomeToggleBookmarkEvent) {
      _onToggleBookmark(event.jobId);
    }
  }

  Future<void> _onLoadData() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));

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
          icon: AppImages.iconFreeLance,
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

      final mockRecentJobs = [
        const JobEntity(
          id: 'r1',
          companyName: 'Apple Inc.',
          logoAsset: 'assets/icons/apple.png',
          title: 'Sr. Product Designer',
          salary: '\$150,000',
          tags: ['Design', 'Full Time'],
          location: 'United States',
          isBookmarked: false,
        ),
        const JobEntity(
          id: 'r2',
          companyName: 'Google LLC',
          logoAsset: 'assets/icons/google.png',
          title: 'Sr. UI/UX Designer',
          salary: '\$165,000',
          tags: ['Design', 'Full Time'],
          location: 'Singapore',
          isBookmarked: false,
        ),
      ];

      emit(
        state.copyWith(
          isLoading: false,
          categories: mockCategories,
          suggestedJobs: mockSuggestedJobs,
          recentJobs: mockRecentJobs,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _onToggleBookmark(String jobId) {
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

    emit(
      state.copyWith(
        suggestedJobs: updatedSuggested,
        recentJobs: updatedRecent,
      ),
    );
  }
}
