import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/domain/entities/messages_entity.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view_model/messages_event.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view_model/messages_state.dart';

@injectable
class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(const MessagesState());

  void doIntent(MessagesEvent event) {
    if (event is MessagesLoadEvent) {
      _onLoadChats();
    }
  }

  Future<void> _onLoadChats() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      // Simulate API loading
      await Future.delayed(const Duration(milliseconds: 500));

      final mockChats = [
        const MessagesEntity(
          id: '1',
          name: 'Sara Ahmed',
          message: 'Sent a voice message',
          time: 'Just Now',
          avatarUrl: AppImages.imageUserPhoto,
          isVoiceMessage: true,
          unreadCount: 0,
          isRead: true,
        ),
      ];

      emit(state.copyWith(isLoading: false, chats: mockChats));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
