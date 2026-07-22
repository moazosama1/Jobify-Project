import 'package:json_annotation/json_annotation.dart';

part 'get_job_applications_response.g.dart';

@JsonSerializable()
class GetJobApplicationsResponse {
  final String? message;
  final List<JobApplicationDto>? applications;

  GetJobApplicationsResponse({
    this.message,
    this.applications,
  });

  factory GetJobApplicationsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetJobApplicationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetJobApplicationsResponseToJson(this);
}

@JsonSerializable()
class JobApplicationDto {
  @JsonKey(name: '_id')
  final String? id;
  final dynamic jobId;
  @JsonKey(fromJson: _parseUserId)
  final ApplicationUserDto? userId;
  final String? status;
  final String? resume;
  final String? coverLetter;
  final String? createdAt;

  JobApplicationDto({
    this.id,
    this.jobId,
    this.userId,
    this.status,
    this.resume,
    this.coverLetter,
    this.createdAt,
  });

  static ApplicationUserDto? _parseUserId(dynamic json) {
    if (json is String) {
      return ApplicationUserDto(id: json);
    }
    if (json is Map<String, dynamic>) {
      return ApplicationUserDto.fromJson(json);
    }
    return null;
  }

  factory JobApplicationDto.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$JobApplicationDtoToJson(this);
}

@JsonSerializable()
class ApplicationUserDto {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profileImage;

  ApplicationUserDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.profileImage,
  });

  factory ApplicationUserDto.fromJson(Map<String, dynamic> json) =>
      _$ApplicationUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationUserDtoToJson(this);
}
