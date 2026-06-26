sealed class HrChatScreenEvent {}

class LoadHrChatScreenEvent extends HrChatScreenEvent {
  final String receiverId;
  LoadHrChatScreenEvent(this.receiverId);
}

class SendMessageHrChatScreenEvent extends HrChatScreenEvent {
  final String text;
  SendMessageHrChatScreenEvent(this.text);
}
