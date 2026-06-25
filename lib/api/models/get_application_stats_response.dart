import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/domain/entities/application_stats_entity.dart';

part 'get_application_stats_response.g.dart';

@JsonSerializable()
class GetApplicationStatsResponse {
  final String? message;
  final ApplicationStatsDto? stats;

  GetApplicationStatsResponse({this.message, this.stats});

  factory GetApplicationStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetApplicationStatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetApplicationStatsResponseToJson(this);

  ApplicationStatsEntity toEntity() {
    return stats?.toEntity() ?? const ApplicationStatsEntity(
      total: 0,
      pending: 0,
      reviewed: 0,
      interview: 0,
      accepted: 0,
      rejected: 0,
    );
  }
}

@JsonSerializable()
class ApplicationStatsDto {
  final int? total;
  final int? pending;
  final int? reviewed;
  final int? interview;
  final int? accepted;
  final int? rejected;
  final int? activeJobs;

  ApplicationStatsDto({
    this.total,
    this.pending,
    this.reviewed,
    this.interview,
    this.accepted,
    this.rejected,
    this.activeJobs,
  });

  factory ApplicationStatsDto.fromJson(Map<String, dynamic> json) =>
      _$ApplicationStatsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationStatsDtoToJson(this);

  ApplicationStatsEntity toEntity() {
    return ApplicationStatsEntity(
      total: total ?? 0,
      pending: pending ?? 0,
      reviewed: reviewed ?? 0,
      interview: interview ?? 0,
      accepted: accepted ?? 0,
      rejected: rejected ?? 0,
      activeJobs: activeJobs,
    );
  }
}
