import 'package:equatable/equatable.dart';

class MessagesEntity extends Equatable {
  final String id;
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final bool isVoiceMessage;
  final int unreadCount;
  final bool isRead;

  const MessagesEntity({
    required this.id,
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    this.isVoiceMessage = false,
    this.unreadCount = 0,
    this.isRead = false,
  });

  MessagesEntity copyWith({
    String? id,
    String? name,
    String? message,
    String? time,
    String? avatarUrl,
    bool? isVoiceMessage,
    int? unreadCount,
    bool? isRead,
  }) {
    return MessagesEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      message: message ?? this.message,
      time: time ?? this.time,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVoiceMessage: isVoiceMessage ?? this.isVoiceMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    message,
    time,
    avatarUrl,
    isVoiceMessage,
    unreadCount,
    isRead,
  ];
}
