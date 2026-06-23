import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'ai_chat_message_model.g.dart';

@JsonSerializable()
class AiChatMessageModel extends Equatable {
  final String id;
  final String text;
  
  @JsonKey(name: 'is_user')
  final bool isUser;
  
  final String time;

  const AiChatMessageModel({
    required this.id,
    required this.text,
    required this.isUser,
    required this.time,
  });

  factory AiChatMessageModel.fromJson(Map<String, dynamic> json) => _$AiChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$AiChatMessageModelToJson(this);

  @override
  List<Object?> get props => [id, text, isUser, time];
}
