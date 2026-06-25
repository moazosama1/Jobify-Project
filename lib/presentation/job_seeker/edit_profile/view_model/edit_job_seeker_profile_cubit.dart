import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'package:jobify_project/domain/use_cases/auth/get_user_profile_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/update_basic_info_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/add_experience_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/update_experience_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/delete_experience_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/add_education_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/update_education_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/delete_education_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/update_skills_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/upload_resume_use_case.dart';

import 'edit_job_seeker_profile_event.dart';
import 'edit_job_seeker_profile_state.dart';

@injectable
class EditJobSeekerProfileCubit extends Cubit<EditJobSeekerProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateBasicInfoUseCase _updateBasicInfoUseCase;
  final AddExperienceUseCase _addExperienceUseCase;
  final UpdateExperienceUseCase _updateExperienceUseCase;
  final DeleteExperienceUseCase _deleteExperienceUseCase;
  final AddEducationUseCase _addEducationUseCase;
  final UpdateEducationUseCase _updateEducationUseCase;
  final DeleteEducationUseCase _deleteEducationUseCase;
  final UpdateSkillsUseCase _updateSkillsUseCase;
  final UploadResumeUseCase _uploadResumeUseCase;

  EditJobSeekerProfileCubit(
    this._getUserProfileUseCase,
    this._updateBasicInfoUseCase,
    this._addExperienceUseCase,
    this._updateExperienceUseCase,
    this._deleteExperienceUseCase,
    this._addEducationUseCase,
    this._updateEducationUseCase,
    this._deleteEducationUseCase,
    this._updateSkillsUseCase,
    this._uploadResumeUseCase,
  ) : super(const EditJobSeekerProfileState()) {
    _init();
  }

  void _init() {
    doIntent(LoadEditProfileEvent());
  }

  void doIntent(EditJobSeekerProfileEvent event) {
    switch (event) {
      case LoadEditProfileEvent():
        _onLoadEditProfileEvent(event);
        break;
      case UpdateBasicInfoEvent():
        _onUpdateBasicInfoEvent(event);
        break;
      case AddExperienceEvent():
        _onAddExperienceEvent(event);
        break;
      case UpdateExperienceEvent():
        _onUpdateExperienceEvent(event);
        break;
      case DeleteExperienceEvent():
        _onDeleteExperienceEvent(event);
        break;
      case AddEducationEvent():
        _onAddEducationEvent(event);
        break;
      case UpdateEducationEvent():
        _onUpdateEducationEvent(event);
        break;
      case DeleteEducationEvent():
        _onDeleteEducationEvent(event);
        break;
      case UpdateSkillsEvent():
        _onUpdateSkillsEvent(event);
        break;
      case UploadResumeEvent():
        _onUploadResumeEvent(event);
        break;
    }
  }

  Future<void> _onLoadEditProfileEvent(LoadEditProfileEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _getUserProfileUseCase();
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, data: result.data, clearError: true),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _onUpdateBasicInfoEvent(UpdateBasicInfoEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _updateBasicInfoUseCase(event.request);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            clearError: true,
            successMessage: "Basic info updated successfully",
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _onAddExperienceEvent(AddExperienceEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _addExperienceUseCase(event.request);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            clearError: true,
            successMessage: "Experience added successfully",
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _onUpdateExperienceEvent(UpdateExperienceEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _updateExperienceUseCase(event.id, event.request);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            clearError: true,
            successMessage: "Experience updated successfully",
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _onDeleteExperienceEvent(DeleteExperienceEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _deleteExperienceUseCase(event.id);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            clearError: true,
            successMessage: "Experience deleted successfully",
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _onAddEducationEvent(AddEducationEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _addEducationUseCase(event.request);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            clearError: true,
            successMessage: "Education added successfully",
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _onUpdateEducationEvent(UpdateEducationEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _updateEducationUseCase(event.id, event.request);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            clearError: true,
            successMessage: "Education updated successfully",
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _onDeleteEducationEvent(DeleteEducationEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _deleteEducationUseCase(event.id);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            clearError: true,
            successMessage: "Education deleted successfully",
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _onUpdateSkillsEvent(UpdateSkillsEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _updateSkillsUseCase(event.request);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            clearError: true,
            successMessage: "Skills updated successfully",
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _onUploadResumeEvent(UploadResumeEvent event) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _uploadResumeUseCase(event.filePath);
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            clearError: true,
            successMessage: "Resume uploaded successfully",
          ),
        );
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }
}
