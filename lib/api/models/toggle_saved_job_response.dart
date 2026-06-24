import 'package:json_annotation/json_annotation.dart';

part 'toggle_saved_job_response.g.dart';

@JsonSerializable()
class ToggleSavedJobResponse {
  final String? message;
  // We can ignore the user object for now since we just need the success state

  ToggleSavedJobResponse({this.message});

  factory ToggleSavedJobResponse.fromJson(Map<String, dynamic> json) =>
      _$ToggleSavedJobResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ToggleSavedJobResponseToJson(this);
}
