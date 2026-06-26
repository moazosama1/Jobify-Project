import 'package:equatable/equatable.dart';
import 'package:jobify_project/domain/entities/update_basic_info_request_entity.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadEditProfileEvent extends EditProfileEvent {}

class UpdateBasicInfoEvent extends EditProfileEvent {
  final UpdateBasicInfoRequestEntity request;
  const UpdateBasicInfoEvent(this.request);

  @override
  List<Object?> get props => [request];
}
