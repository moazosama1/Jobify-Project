import 'package:json_annotation/json_annotation.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';
part 'message_response.g.dart';

@JsonSerializable()
class MessageResponse {
  @JsonKey(name: '_id')
  final String? id;
  final dynamic senderId;
  final dynamic receiverId;
  final String? content;
  final String? status;
  final String? createdAt;
  final bool? isDeletedBySender;
  final bool? isDeletedByReceiver;

  MessageResponse(this.id, this.senderId, this.receiverId, this.content, this.status, this.createdAt, this.isDeletedBySender, this.isDeletedByReceiver);

  factory MessageResponse.fromJson(Map<String, dynamic> json) => _$MessageResponseFromJson(json);

  MessageEntity toEntity(String currentUserId) {
    final senderStr = _getStringId(senderId);
    final receiverStr = _getStringId(receiverId);
    return MessageEntity(
      id: id ?? "",
      text: content ?? "",
      time: createdAt ?? "",
      isMe: senderStr == currentUserId,
      senderId: senderStr,
      receiverId: receiverStr,
      status: status ?? "",
    );
  }

  String _getStringId(dynamic value) {
    if (value == null) return "";
    if (value is String) return value;
    if (value is Map) {
      return value['_id']?.toString() ?? value['id']?.toString() ?? "";
    }
    return value.toString();
  }
}
