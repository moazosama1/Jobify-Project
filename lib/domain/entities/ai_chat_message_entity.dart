import 'package:equatable/equatable.dart';

class AiChatMessageEntity extends Equatable {
  final String id;
  final String text;
  final bool isUser;
  final String time;

  const AiChatMessageEntity({
    required this.id,
    required this.text,
    required this.isUser,
    required this.time,
  });

  @override
  List<Object?> get props => [id, text, isUser, time];
}
