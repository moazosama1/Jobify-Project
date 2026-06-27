import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/services/socket_service.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';
import 'package:jobify_project/domain/use_cases/get_chat_history_use_case.dart';
import 'package:jobify_project/domain/use_cases/send_message_use_case.dart';
import 'hr_chat_screen_event.dart';
import 'hr_chat_screen_state.dart';

@injectable
class HrChatScreenCubit extends Cubit<HrChatScreenState> {
  final GetChatHistoryUseCase _getChatHistoryUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final SocketService _socketService;
  StreamSubscription? _newMessageSub;

  String _currentReceiverId = "";

  HrChatScreenCubit(
    this._getChatHistoryUseCase,
    this._sendMessageUseCase,
    this._socketService,
  ) : super(const HrChatScreenState()) {
    _init();
  }

  void _init() {
    _socketService.connect();
  }

  void doIntent(HrChatScreenEvent event) {
    switch (event) {
      case LoadHrChatScreenEvent():
        _currentReceiverId = event.receiverId;
        _onLoadMessages(event.receiverId, event.userName, event.userAvatar);
        break;
      case SendMessageHrChatScreenEvent():
        _onSendMessage(event.text);
        break;
    }
  }

  Future<void> _onLoadMessages(String receiverId, String? userName, String? userAvatar) async {
    emit(state.copyWith(
      isLoading: true,
      clearError: true,
      receiverId: receiverId,
      participantName: userName ?? state.participantName,
      participantAvatar: userAvatar ?? state.participantAvatar,
    ));

    final result = await _getChatHistoryUseCase(receiverId);
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isLoading: false,
            data: result.data,
            receiverId: receiverId,
            participantName: userName ?? (state.participantName.isNotEmpty ? state.participantName : 'Mazen Mohammed'),
            participantAvatar: userAvatar ?? (state.participantAvatar.isNotEmpty ? state.participantAvatar : 'https://i.pravatar.cc/150?img=12'),
            statusText: 'is typing...',
          ),
        );
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
        break;
    }

    _newMessageSub?.cancel();
    _newMessageSub = _socketService.onNewMessage.listen((data) {
      final senderData = data['senderId'];
      final senderIdStr = senderData is Map
          ? (senderData['_id'] ?? senderData['id'])?.toString()
          : senderData?.toString();
      if (senderIdStr == receiverId) {
        doIntent(LoadHrChatScreenEvent(receiverId, userName: userName, userAvatar: userAvatar));
      }
    });
  }

  Future<void> _onSendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final newMessage = MessageEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      time: 'Just Now',
      isMe: true,
    );
    final updatedMessages = List<MessageEntity>.from(state.data ?? [])
      ..add(newMessage);
    emit(state.copyWith(data: updatedMessages));

    final result = await _sendMessageUseCase(_currentReceiverId, text);
    switch (result) {
      case ApiErrorResult():
        emit(state.copyWith(errorMessage: result.errorMessage));
        break;
      case ApiSuccessResult():
        final realMessage = result.data;
        final idx = updatedMessages.indexWhere((m) => m.id == newMessage.id);
        if (idx != -1) {
          updatedMessages[idx] = realMessage;
        } else {
          updatedMessages.add(realMessage);
        }
        emit(state.copyWith(data: List.from(updatedMessages)));
        break;
    }
  }

  @override
  Future<void> close() {
    _newMessageSub?.cancel();
    return super.close();
  }
}
