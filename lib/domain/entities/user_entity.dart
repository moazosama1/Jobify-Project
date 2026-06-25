import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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
  
  final List<dynamic> skills;
  final List<dynamic> jobTypePreferences;
  final List<dynamic> savedJobs;
  final bool confirmed;
  final List<dynamic> friends;
  final List<dynamic> blockedUsers;
  final bool isActive;
  final bool notificationsEnabled;
  final List<dynamic> experience;
  final List<dynamic> education;
  final String? resume;
  final String? profileImage;
  
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String userName;
  final String id;
  final String? bio;

  const UserEntity({
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
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.userName,
    required this.id,
    this.bio,
  });

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
        profileImage,
        createdAt,
        updatedAt,
        version,
        userName,
        id,
        bio,
      ];
}
