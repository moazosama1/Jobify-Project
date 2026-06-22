import 'package:equatable/equatable.dart';

class SignUpRequestEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? cPassword;
  final int? age;
  final String? location;
  final String? phoneNumber;
  final String? gender;
  final String? role;

  const SignUpRequestEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.cPassword,
    this.age,
    this.location,
    this.phoneNumber,
    this.gender,
    this.role,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        cPassword,
        age,
        location,
        phoneNumber,
        gender,
        role,
      ];
}
