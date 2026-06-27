sealed class ChatScreenEvent {}

class LoadChatScreenEvent extends ChatScreenEvent {
  final String receiverId;
  final String? userName;
  final String? userAvatar;
  LoadChatScreenEvent(this.receiverId, {this.userName, this.userAvatar});
}

class SendMessageChatScreenEvent extends ChatScreenEvent {
  final String text;
  SendMessageChatScreenEvent(this.text);
}
