sealed class HrChatScreenEvent {}

class HrChatScreenLoadEvent extends HrChatScreenEvent {}

class HrChatScreenSendMessageEvent extends HrChatScreenEvent {
  final String text;
  HrChatScreenSendMessageEvent(this.text);
}
