import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/api/models/job_dto.dart';

part 'get_job_by_id_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetJobByIdResponse {
  final String? message;
  final JobDto? job;

  GetJobByIdResponse({
    this.message,
    this.job,
  });

  factory GetJobByIdResponse.fromJson(Map<String, dynamic> json) => _$GetJobByIdResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetJobByIdResponseToJson(this);
}
