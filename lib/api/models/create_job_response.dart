import 'package:jobify_project/api/models/job_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_job_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateJobResponse {
  final String? message;
  final JobDto? job;

  CreateJobResponse({this.message, this.job});

  factory CreateJobResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateJobResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateJobResponseToJson(this);
}
