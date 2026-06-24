import 'package:equatable/equatable.dart';

abstract class SavedJobsEvent extends Equatable {
  const SavedJobsEvent();

  @override
  List<Object?> get props => [];
}

class SavedJobsLoadEvent extends SavedJobsEvent {}

class SavedJobsRemoveEvent extends SavedJobsEvent {
  final String jobId;

  const SavedJobsRemoveEvent(this.jobId);

  @override
  List<Object?> get props => [jobId];
}

class SavedJobsSearchEvent extends SavedJobsEvent {
  final String query;

  const SavedJobsSearchEvent(this.query);

  @override
  List<Object?> get props => [query];
}
