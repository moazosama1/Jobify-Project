import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';
import 'hr_chat_screen_event.dart';
import 'hr_chat_screen_state.dart';

@injectable
class HrChatScreenCubit extends Cubit<HrChatScreenState> {
  HrChatScreenCubit() : super(const HrChatScreenState());

  void doIntent(HrChatScreenEvent event) {
    if (event is HrChatScreenLoadEvent) {
      _onLoadMessages();
    } else if (event is HrChatScreenSendMessageEvent) {
      _onSendMessage(event.text);
    }
  }

  void _onLoadMessages() {
    emit(state.copyWith(isLoading: true, clearError: true));
    
    final mockMessages = [
      const MessageEntity(
        id: '1',
        text: 'Halo, bro',
        time: '08:50 AM',
        isMe: true,
      ),
      const MessageEntity(
        id: '2',
        text: "What's going on? Why do we have no money at all?",
        time: '',
        isMe: true,
      ),
      const MessageEntity(
        id: '3',
        text: 'so, why should i buy them...',
        time: '09:01 AM',
        isMe: false,
      ),
      const MessageEntity(
        id: '4',
        text: 'Halo, bro',
        time: '09:20 AM',
        isMe: true,
      ),
      const MessageEntity(
        id: '5',
        text: "What's going on? Why do we have no money at all?",
        time: '',
        isMe: true,
      ),
      const MessageEntity(
        id: '6',
        text: "What's going on? Why do we have no money at all?",
        time: '',
        isMe: true,
      ),
      const MessageEntity(
        id: '7',
        text: 'so, why should i buy them...',
        time: '09:01 AM',
        isMe: false,
      ),
    ];

    emit(state.copyWith(
      isLoading: false,
      messages: mockMessages,
      participantName: 'Mazen Mohammed',
      participantAvatar: 'https://i.pravatar.cc/150?img=12',
      statusText: 'is typing...',
    ));
  }

  void _onSendMessage(String text) {
    if (text.trim().isEmpty) return;

    final now = DateTime.now();
    final timeStr = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";

    final newMessage = MessageEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      time: timeStr,
      isMe: true,
    );

    final updatedMessages = List<MessageEntity>.from(state.messages)..add(newMessage);
    emit(state.copyWith(messages: updatedMessages));
  }
}
