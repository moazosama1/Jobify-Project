import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(const EditProfileState());

  void doIntent(EditProfileEvent event) {
    if (event is EditProfileLoadEvent) {
      _onLoadData();
    } else if (event is EditProfileSubmitEvent) {
      _onSubmit(event);
    }
  }

  Future<void> _onLoadData() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      emit(state.copyWith(
        isLoading: false,
        name: 'Ahmed Elsaied',
        contactNumber: '+00123456789',
        dateOfBirth: '2000-01-01',
        aboutYou: 'UX/UI Designer passionate about building functional products.',
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onSubmit(EditProfileSubmitEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(state.copyWith(
        isLoading: false,
        name: event.name,
        contactNumber: event.contactNumber,
        dateOfBirth: event.dateOfBirth,
        aboutYou: event.aboutYou,
        photoUrl: event.photoUrl,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
