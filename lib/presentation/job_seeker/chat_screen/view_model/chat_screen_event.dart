sealed class ChatScreenEvent {}

class ChatScreenLoadEvent extends ChatScreenEvent {}

class ChatScreenSendMessageEvent extends ChatScreenEvent {
  final String text;
  ChatScreenSendMessageEvent(this.text);
}
