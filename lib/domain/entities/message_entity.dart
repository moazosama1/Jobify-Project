import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String text;
  final String time;
  final bool isMe;
  final String senderId;
  final String receiverId;
  final String status;

  const MessageEntity({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
    this.senderId = "",
    this.receiverId = "",
    this.status = "",
  });

  @override
  List<Object?> get props => [id, text, time, isMe, senderId, receiverId, status];
}
