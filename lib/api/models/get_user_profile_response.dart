import 'package:jobify_project/api/models/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'get_user_profile_response.g.dart';

@JsonSerializable()
class GetUserProfileResponse extends Equatable {
  final String message;
  final UserDto user;

  const GetUserProfileResponse({
    required this.message,
    required this.user,
  });

  factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserProfileResponseToJson(this);

  @override
  List<Object?> get props => [message, user];
}
