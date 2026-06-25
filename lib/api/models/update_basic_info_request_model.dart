import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/domain/entities/update_basic_info_request_entity.dart';

part 'update_basic_info_request_model.g.dart';

@JsonSerializable()
class UpdateBasicInfoRequestModel {
  final String? firstName;
  final String? lastName;
  final int? age;
  final String? location;
  final String? phoneNumber;
  final String? bio;
  final String? gender;
  final String? userName;
  final num? expectedSalary;
  final List<String>? jobTypePreferences;
  final bool? notificationsEnabled;
  final Map<String, String>? socialLinks;

  UpdateBasicInfoRequestModel({
    this.firstName,
    this.lastName,
    this.age,
    this.location,
    this.phoneNumber,
    this.bio,
    this.gender,
    this.userName,
    this.expectedSalary,
    this.jobTypePreferences,
    this.notificationsEnabled,
    this.socialLinks,
  });

  factory UpdateBasicInfoRequestModel.fromEntity(UpdateBasicInfoRequestEntity entity) {
    return UpdateBasicInfoRequestModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      age: entity.age,
      location: entity.location,
      phoneNumber: entity.phoneNumber,
      bio: entity.bio,
      gender: entity.gender,
      userName: entity.userName,
      expectedSalary: entity.expectedSalary,
      jobTypePreferences: entity.jobTypePreferences,
      notificationsEnabled: entity.notificationsEnabled,
      socialLinks: entity.socialLinks,
    );
  }

  factory UpdateBasicInfoRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateBasicInfoRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBasicInfoRequestModelToJson(this);
}
