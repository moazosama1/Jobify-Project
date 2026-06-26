sealed class ChatScreenEvent {}

class LoadChatScreenEvent extends ChatScreenEvent {
  final String receiverId;
  LoadChatScreenEvent(this.receiverId);
}

class SendMessageChatScreenEvent extends ChatScreenEvent {
  final String text;
  SendMessageChatScreenEvent(this.text);
}
