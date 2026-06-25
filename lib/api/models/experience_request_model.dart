import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/domain/entities/experience_request_entity.dart';

part 'experience_request_model.g.dart';

@JsonSerializable()
class ExperienceRequestModel {
  final String? company;
  final String? position;
  final String? startDate;
  final String? endDate;
  final bool? isCurrent;
  final String? description;

  ExperienceRequestModel({
    this.company,
    this.position,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
  });

  factory ExperienceRequestModel.fromEntity(ExperienceRequestEntity entity) {
    return ExperienceRequestModel(
      company: entity.company,
      position: entity.position,
      startDate: entity.startDate?.toIso8601String(),
      endDate: entity.endDate?.toIso8601String(),
      isCurrent: entity.isCurrent,
      description: entity.description,
    );
  }

  factory ExperienceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ExperienceRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceRequestModelToJson(this);
}
