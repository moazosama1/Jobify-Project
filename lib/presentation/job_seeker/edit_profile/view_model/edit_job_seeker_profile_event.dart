import 'package:equatable/equatable.dart';
import 'package:jobify_project/domain/entities/update_basic_info_request_entity.dart';
import 'package:jobify_project/domain/entities/experience_request_entity.dart';
import 'package:jobify_project/domain/entities/education_request_entity.dart';
import 'package:jobify_project/domain/entities/update_skills_request_entity.dart';

sealed class EditJobSeekerProfileEvent extends Equatable {
  const EditJobSeekerProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadEditProfileEvent extends EditJobSeekerProfileEvent {}

class UpdateBasicInfoEvent extends EditJobSeekerProfileEvent {
  final UpdateBasicInfoRequestEntity request;
  const UpdateBasicInfoEvent(this.request);
  @override
  List<Object?> get props => [request];
}

class AddExperienceEvent extends EditJobSeekerProfileEvent {
  final ExperienceRequestEntity request;
  const AddExperienceEvent(this.request);
  @override
  List<Object?> get props => [request];
}

class UpdateExperienceEvent extends EditJobSeekerProfileEvent {
  final String id;
  final ExperienceRequestEntity request;
  const UpdateExperienceEvent(this.id, this.request);
  @override
  List<Object?> get props => [id, request];
}

class DeleteExperienceEvent extends EditJobSeekerProfileEvent {
  final String id;
  const DeleteExperienceEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class AddEducationEvent extends EditJobSeekerProfileEvent {
  final EducationRequestEntity request;
  const AddEducationEvent(this.request);
  @override
  List<Object?> get props => [request];
}

class UpdateEducationEvent extends EditJobSeekerProfileEvent {
  final String id;
  final EducationRequestEntity request;
  const UpdateEducationEvent(this.id, this.request);
  @override
  List<Object?> get props => [id, request];
}

class DeleteEducationEvent extends EditJobSeekerProfileEvent {
  final String id;
  const DeleteEducationEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class UpdateSkillsEvent extends EditJobSeekerProfileEvent {
  final UpdateSkillsRequestEntity request;
  const UpdateSkillsEvent(this.request);
  @override
  List<Object?> get props => [request];
}

class UploadResumeEvent extends EditJobSeekerProfileEvent {
  final String filePath;
  const UploadResumeEvent(this.filePath);
  @override
  List<Object?> get props => [filePath];
}
