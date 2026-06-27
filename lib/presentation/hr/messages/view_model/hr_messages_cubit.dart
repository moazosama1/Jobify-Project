import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/services/socket_service.dart';
import 'package:jobify_project/domain/entities/messages_entity.dart';
import 'package:jobify_project/domain/use_cases/get_conversations_use_case.dart';
import 'hr_messages_event.dart';
import 'hr_messages_state.dart';

@injectable
class HrMessagesCubit extends Cubit<HrMessagesState> {
  final GetConversationsUseCase _getConversationsUseCase;
  final SocketService _socketService;
  StreamSubscription? _newMessageSub;

  HrMessagesCubit(this._getConversationsUseCase, this._socketService)
      : super(const HrMessagesState()) {
    _init();
  }

  void _init() {
    doIntent(LoadHrMessagesEvent());
    _socketService.connect();
    _newMessageSub = _socketService.onNewMessage.listen((data) {
      doIntent(LoadHrMessagesEvent());
    });
  }

  void doIntent(HrMessagesEvent event) {
    if (event is LoadHrMessagesEvent) {
      _onLoadChats();
    }
  }

  Future<void> _onLoadChats() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await _getConversationsUseCase();
    switch (result) {
      case ApiSuccessResult():
        final conversations = result.data;
        final mappedChats = conversations.map((c) {
          return MessagesEntity(
            id: c.otherUser.id,
            name: '${c.otherUser.firstName} ${c.otherUser.lastName}',
            message: c.lastMessage?.text ?? '',
            time: c.lastMessage?.time ?? '',
            avatarUrl: c.otherUser.profileImage,
            isVoiceMessage: false,
            unreadCount: c.unreadCount,
            isRead: c.unreadCount == 0,
          );
        }).toList();

        emit(state.copyWith(isLoading: false, chats: mappedChats));
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
        break;
    }
  }

  @override
  Future<void> close() {
    _newMessageSub?.cancel();
    return super.close();
  }
}
