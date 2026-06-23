import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/api/models/job_dto.dart';

part 'get_my_jobs_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetMyJobsResponse {
  final String? message;
  final List<JobDto>? jobs;

  GetMyJobsResponse({this.message, this.jobs});

  factory GetMyJobsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMyJobsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMyJobsResponseToJson(this);
}
