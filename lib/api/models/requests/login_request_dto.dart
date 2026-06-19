import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto extends Equatable {
  final String email;
  final String password;

  const LoginRequestDto({
    required this.email,
    required this.password,
  });

  /// Factory constructor for creating a new LoginRequestDto instance from a map.
  factory LoginRequestDto.fromJson(Map<String, dynamic> json) => _$LoginRequestDtoFromJson(json);

  /// Converts this LoginRequestDto instance into a map.
  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);

  @override
  List<Object?> get props => [email, password];
}