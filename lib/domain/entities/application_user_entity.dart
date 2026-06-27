import 'package:equatable/equatable.dart';

class ApplicationUserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? profileImage;

  const ApplicationUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profileImage,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, email, profileImage];
}
