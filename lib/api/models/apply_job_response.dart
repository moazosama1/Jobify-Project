import 'package:json_annotation/json_annotation.dart';
part 'apply_job_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ApplyJobResponse {
  final String? message;
  final ApplyJobApplicationDto? application;

  ApplyJobResponse({
    this.message,
    this.application,
  });

  factory ApplyJobResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplyJobResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyJobResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ApplyJobApplicationDto {
  @JsonKey(name: '_id')
  final String? id;
  final String? jobId;
  final String? userId;
  final String? status;
  final String? resume;
  final String? coverLetter;
  final String? createdAt;

  ApplyJobApplicationDto({
    this.id,
    this.jobId,
    this.userId,
    this.status,
    this.resume,
    this.coverLetter,
    this.createdAt,
  });

  factory ApplyJobApplicationDto.fromJson(Map<String, dynamic> json) =>
      _$ApplyJobApplicationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyJobApplicationDtoToJson(this);
}
