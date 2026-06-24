import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/api/models/job_dto.dart';

part 'get_saved_jobs_response.g.dart';

@JsonSerializable()
class GetSavedJobsResponse {
  final String? message;
  final int? count;
  final List<JobDto>? jobs;

  GetSavedJobsResponse({this.message, this.count, this.jobs});

  factory GetSavedJobsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSavedJobsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSavedJobsResponseToJson(this);
}
