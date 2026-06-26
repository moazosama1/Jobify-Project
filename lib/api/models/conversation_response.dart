import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/domain/entities/conversation_entity.dart';
import 'message_response.dart';
part 'conversation_response.g.dart';

@JsonSerializable()
class ConversationResponse {
  final ConversationOtherUserResponse? otherUser;
  final MessageResponse? lastMessage;
  final int? unreadCount;

  ConversationResponse(this.otherUser, this.lastMessage, this.unreadCount);

  factory ConversationResponse.fromJson(Map<String, dynamic> json) => _$ConversationResponseFromJson(json);

  ConversationEntity toEntity(String currentUserId) {
    return ConversationEntity(
      otherUser: otherUser?.toEntity() ?? const ConversationOtherUserEntity(id: "", firstName: "", lastName: "", profileImage: "", isActive: false, isOnline: false),
      lastMessage: lastMessage?.toEntity(currentUserId),
      unreadCount: unreadCount ?? 0,
    );
  }
}

@JsonSerializable()
class ConversationOtherUserResponse {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final bool? isActive;
  final bool? isOnline;

  ConversationOtherUserResponse(this.id, this.firstName, this.lastName, this.profileImage, this.isActive, this.isOnline);

  factory ConversationOtherUserResponse.fromJson(Map<String, dynamic> json) => _$ConversationOtherUserResponseFromJson(json);

  ConversationOtherUserEntity toEntity() {
    return ConversationOtherUserEntity(
      id: id ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      profileImage: profileImage ?? "",
      isActive: isActive ?? false,
      isOnline: isOnline ?? false,
    );
  }
}
