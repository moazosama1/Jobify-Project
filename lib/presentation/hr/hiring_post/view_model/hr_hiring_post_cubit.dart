import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'hr_hiring_post_event.dart';
import 'hr_hiring_post_state.dart';

@injectable
class HrHiringPostCubit extends Cubit<HrHiringPostState> {
  HrHiringPostCubit() : super(const HrHiringPostState());

  void doIntent(HrHiringPostEvent event) {
    if (event is HrHiringPostSubmitEvent) {
      _onSubmitPost(event);
    }
  }

  Future<void> _onSubmitPost(HrHiringPostSubmitEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      // Simulate API call to create job post
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(state.copyWith(
        isLoading: false,
        jobTitle: event.jobTitle,
        positionLevel: event.positionLevel,
        yearsOfExperience: event.yearsOfExperience,
        location: event.location,
        education: event.education,
        jobRequirements: event.jobRequirements,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
