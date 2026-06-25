import 'package:equatable/equatable.dart';
import 'package:jobify_project/core/enums/gender_enum.dart';
import 'package:jobify_project/core/enums/rule_enum.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterSubmittedEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String age;
  final String location;
  final String phoneNumber;
  final Gender gender;
  final Rule role;
  final String email;
  final String password;
  final String confirmPassword;
  final String? profileImage;

  const RegisterSubmittedEvent({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.location,
    required this.phoneNumber,
    required this.gender,
    required this.role,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.profileImage,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    age,
    location,
    phoneNumber,
    gender,
    role,
    email,
    password,
    confirmPassword,
    profileImage,
  ];
}

class RegisterGoogleLoginClickedEvent extends RegisterEvent {}
