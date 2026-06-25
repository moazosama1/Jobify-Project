import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/domain/entities/update_skills_request_entity.dart';

part 'update_skills_request_model.g.dart';

@JsonSerializable()
class UpdateSkillsRequestModel {
  final List<String> skills;

  UpdateSkillsRequestModel({
    required this.skills,
  });

  factory UpdateSkillsRequestModel.fromEntity(UpdateSkillsRequestEntity entity) {
    return UpdateSkillsRequestModel(
      skills: entity.skills,
    );
  }

  factory UpdateSkillsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateSkillsRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSkillsRequestModelToJson(this);
}
