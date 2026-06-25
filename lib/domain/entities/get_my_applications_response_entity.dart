import 'package:equatable/equatable.dart';
import 'package:jobify_project/domain/entities/my_job_application_entity.dart';
import 'package:jobify_project/domain/entities/pagination_entity.dart';

class GetMyApplicationsResponseEntity extends Equatable {
  final String message;
  final PaginationEntity? pagination;
  final List<MyJobApplicationEntity> applications;

  const GetMyApplicationsResponseEntity({
    required this.message,
    this.pagination,
    required this.applications,
  });

  @override
  List<Object?> get props => [message, pagination, applications];
}
