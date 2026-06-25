

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';

@JsonSerializable()
class UserDto extends Equatable {
  @JsonKey(name: '_id')
  final String mongoId; 
  
  final String firstName;
  final String lastName;
  final String email;
  final String provider;
  final String? password; 
  final int age;
  final String gender;
  final String phoneNumber;
  final String location;
  final String role;
  
  @JsonKey(defaultValue: [])
  final List<dynamic> skills;
  @JsonKey(defaultValue: [])
  final List<dynamic> jobTypePreferences;
  @JsonKey(defaultValue: [])
  final List<dynamic> savedJobs;
  @JsonKey(defaultValue: false)
  final bool confirmed;
  @JsonKey(defaultValue: [])
  final List<dynamic> friends;
  @JsonKey(defaultValue: [])
  final List<dynamic> blockedUsers;
  @JsonKey(defaultValue: false)
  final bool isActive;
  @JsonKey(defaultValue: false)
  final bool notificationsEnabled;
  @JsonKey(defaultValue: [])
  final List<dynamic> experience;
  @JsonKey(defaultValue: [])
  final List<dynamic> education;
  final String? resume;
  
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  @JsonKey(name: '__v', defaultValue: 0)
  final int version;
  
  @JsonKey(defaultValue: '')
  final String userName;
  @JsonKey(defaultValue: '')
  final String id;
  
  final String? bio;

  const UserDto({
    required this.mongoId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.provider,
    this.password,
    required this.age,
    required this.gender,
    required this.phoneNumber,
    required this.location,
    required this.role,
    required this.skills,
    required this.jobTypePreferences,
    required this.savedJobs,
    required this.confirmed,
    required this.friends,
    required this.blockedUsers,
    required this.isActive,
    required this.notificationsEnabled,
    required this.experience,
    required this.education,
    this.resume,
    this.createdAt,
    this.updatedAt,
    required this.version,
    required this.userName,
    required this.id,
    this.bio,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @override
  List<Object?> get props => [
        mongoId,
        firstName,
        lastName,
        email,
        provider,
        password,
        age,
        gender,
        phoneNumber,
        location,
        role,
        skills,
        jobTypePreferences,
        savedJobs,
        confirmed,
        friends,
        blockedUsers,
        isActive,
        notificationsEnabled,
        experience,
        education,
        resume,
        createdAt,
        updatedAt,
        version,
        userName,
        id,
        bio,
      ];
}