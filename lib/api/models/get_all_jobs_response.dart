import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/api/models/job_dto.dart';
import 'package:jobify_project/api/models/pagination_model.dart';

part 'get_all_jobs_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetAllJobsResponse {
  final String? message;
  final PaginationModel? pagination;
  final List<JobDto>? jobs;

  GetAllJobsResponse({
    this.message,
    this.pagination,
    this.jobs,
  });

  factory GetAllJobsResponse.fromJson(Map<String, dynamic> json) => _$GetAllJobsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllJobsResponseToJson(this);
}
