import 'package:equatable/equatable.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';
import 'package:jobify_project/domain/entities/pagination_entity.dart';

class GetAllJobsResponseEntity extends Equatable {
  final String message;
  final PaginationEntity? pagination;
  final List<JobEntity> jobs;

  const GetAllJobsResponseEntity({
    required this.message,
    this.pagination,
    required this.jobs,
  });

  @override
  List<Object?> get props => [message, pagination, jobs];
}
