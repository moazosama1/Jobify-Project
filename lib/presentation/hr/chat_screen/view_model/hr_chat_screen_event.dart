sealed class HrChatScreenEvent {}

class LoadHrChatScreenEvent extends HrChatScreenEvent {
  final String receiverId;
  final String? userName;
  final String? userAvatar;
  LoadHrChatScreenEvent(this.receiverId, {this.userName, this.userAvatar});
}

class SendMessageHrChatScreenEvent extends HrChatScreenEvent {
  final String text;
  SendMessageHrChatScreenEvent(this.text);
}
