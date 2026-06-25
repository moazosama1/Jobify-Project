import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/domain/entities/education_request_entity.dart';

part 'education_request_model.g.dart';

@JsonSerializable()
class EducationRequestModel {
  final String? institution;
  final String? degree;
  final String? fieldOfStudy;
  final String? startDate;
  final String? endDate;
  final bool? isCurrent;
  final String? description;

  EducationRequestModel({
    this.institution,
    this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
  });

  factory EducationRequestModel.fromEntity(EducationRequestEntity entity) {
    return EducationRequestModel(
      institution: entity.institution,
      degree: entity.degree,
      fieldOfStudy: entity.fieldOfStudy,
      startDate: entity.startDate?.toIso8601String(),
      endDate: entity.endDate?.toIso8601String(),
      isCurrent: entity.isCurrent,
      description: entity.description,
    );
  }

  factory EducationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EducationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationRequestModelToJson(this);
}
