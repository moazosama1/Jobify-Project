import 'package:equatable/equatable.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';

class ConversationEntity extends Equatable {
  final ConversationOtherUserEntity otherUser;
  final MessageEntity? lastMessage;
  final int unreadCount;

  const ConversationEntity({
    required this.otherUser,
    this.lastMessage,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [otherUser, lastMessage, unreadCount];
}

class ConversationOtherUserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String profileImage;
  final bool isActive;
  final bool isOnline;

  const ConversationOtherUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.isActive,
    required this.isOnline,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, profileImage, isActive, isOnline];
}
