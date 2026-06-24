
import 'package:jobify_project/api/models/requests/company_snapshot_model.dart';
import 'package:jobify_project/api/models/requests/salary_range_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class JobDto {
  final String? title;
  final CompanySnapshotModel? companySnapshot;
  final dynamic postedBy;
  final String? description;
  final List<String>? responsibilities;
  final List<String>? requirements;
  final List<String>? preferredQualifications;
  final String? location;
  final String? employmentType;
  final String? experienceLevel;
  final SalaryRangeModel? salaryRange;
  final String? applicationDeadline;
  final List<String>? skillsRequired;
  final String? category;
  final int? openings;
  final String? status;
  final int? applicationsCount;
  final bool? isRemote;
  @JsonKey(name: '_id')
  final String? mongoId;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? version;
  final String? id;

  JobDto({
    this.title,
    this.companySnapshot,
    this.postedBy,
    this.description,
    this.responsibilities,
    this.requirements,
    this.preferredQualifications,
    this.location,
    this.employmentType,
    this.experienceLevel,
    this.salaryRange,
    this.applicationDeadline,
    this.skillsRequired,
    this.category,
    this.openings,
    this.status,
    this.applicationsCount,
    this.isRemote,
    this.mongoId,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.id,
  });

  factory JobDto.fromJson(Map<String, dynamic> json) =>
      _$JobDtoFromJson(json);

  Map<String, dynamic> toJson() => _$JobDtoToJson(this);
}
