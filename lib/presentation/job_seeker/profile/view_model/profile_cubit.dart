import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/use_cases/logout_use_case.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_event.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final LogoutUseCase _logoutUseCase;

  ProfileCubit(this._logoutUseCase) : super(const ProfileState());

  void doIntent(ProfileEvent event) {
    if (event is ProfileLoadDataEvent) {
      _onLoadData();
    } else if (event is ProfileUpdateContactInfoEvent) {
      _onUpdateContactInfo(event);
    } else if (event is ProfileLogoutEvent) {
      _onLogout();
    }
  }

  Future<void> _onLoadData() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      // Simulate loading delay
      await Future.delayed(const Duration(milliseconds: 500));

      emit(
        state.copyWith(
          isLoading: false,
          name: 'Mazen Mohammed',
          email: 'mazen.mohammed@example.com',
          phoneNumber: '+1 555-0199',
          title: 'UX Designer',
          description:
              'Creative UX Designer with 6+ years of experience in optimizing user experience through innovative solutions and dynamic interface designs. Successful in enhancing user engagement for well-known brands, providing a compelling user experience to improve brand loyalty and customer retention.',
          appliedCount: 35,
          reviewedCount: 19,
          interviewCount: 10,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _onUpdateContactInfo(ProfileUpdateContactInfoEvent event) {
    emit(
      state.copyWith(
        name: event.name,
        email: event.email,
        phoneNumber: event.phoneNumber,
      ),
    );
  }

  Future<void> _onLogout() async {
    emit(state.copyWith(isLogoutLoading: true, clearError: true));
    final result = await _logoutUseCase();
    if (result is ApiSuccessResult) {
      emit(state.copyWith(isLogoutLoading: false, logoutSuccess: true));
    } else if (result is ApiErrorResult) {
      emit(
        state.copyWith(
          isLogoutLoading: false,
          errorMessage: (result).errorMessage,
        ),
      );
    }
  }
}
