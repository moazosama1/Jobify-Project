import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/api/models/job_dto.dart';
import 'package:jobify_project/api/models/pagination_model.dart';

part 'get_my_applications_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetMyApplicationsResponse {
  final String? message;
  final PaginationModel? pagination;
  final List<MyJobApplicationDto>? applications;

  GetMyApplicationsResponse({
    this.message,
    this.pagination,
    this.applications,
  });

  factory GetMyApplicationsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMyApplicationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMyApplicationsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyJobApplicationDto {
  @JsonKey(name: '_id')
  final String? id;
  final JobDto? jobId;
  final String? userId;
  final String? status;
  final String? resume;
  final String? coverLetter;
  final String? createdAt;

  MyJobApplicationDto({
    this.id,
    this.jobId,
    this.userId,
    this.status,
    this.resume,
    this.coverLetter,
    this.createdAt,
  });

  factory MyJobApplicationDto.fromJson(Map<String, dynamic> json) =>
      _$MyJobApplicationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MyJobApplicationDtoToJson(this);
}
