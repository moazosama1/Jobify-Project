import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/services/socket_service.dart';
import 'package:jobify_project/domain/entities/messages_entity.dart';
import 'package:jobify_project/domain/use_cases/get_conversations_use_case.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view_model/messages_event.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view_model/messages_state.dart';

@injectable
class MessagesCubit extends Cubit<MessagesState> {
  final GetConversationsUseCase _getConversationsUseCase;
  final SocketService _socketService;
  StreamSubscription? _newMessageSub;

  MessagesCubit(this._getConversationsUseCase, this._socketService)
    : super(const MessagesState()) {
    _init();
  }

  void _init() {
    doIntent(LoadMessagesEvent());
    _socketService.connect();
    _newMessageSub = _socketService.onNewMessage.listen((data) {
      doIntent(LoadMessagesEvent());
    });
  }

  void doIntent(MessagesEvent event) {
    switch (event) {
      case LoadMessagesEvent():
        _onLoadChats();
        break;
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

        emit(state.copyWith(isLoading: false, data: mappedChats));
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
