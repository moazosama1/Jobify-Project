import 'package:equatable/equatable.dart';

class UpdateBasicInfoRequestEntity extends Equatable {
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

  const UpdateBasicInfoRequestEntity({
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

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        age,
        location,
        phoneNumber,
        bio,
        gender,
        userName,
        expectedSalary,
        jobTypePreferences,
        notificationsEnabled,
        socialLinks,
      ];
}
