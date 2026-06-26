import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/widgets/chat_item_widget.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import '../../view_model/hr_messages_cubit.dart';
import '../../view_model/hr_messages_state.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/router/route_names.dart';

class HrMessagesScreenViewBody extends StatelessWidget {
  const HrMessagesScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final local = AppLocalizations.of(context);

    return BlocBuilder<HrMessagesCubit, HrMessagesState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CustomLoadingIndicator());
              }

              if (state.errorMessage != null) {
                return Center(
                  child: Text(
                    state.errorMessage!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                );
              }

              final chats = state.chats;
              if (chats.isEmpty) {
                return const Center(
                  child: Text('No Messages'), // Or localize if needed
                );
              }

              return ListView.separated(
                itemCount: chats.length,
                padding: const EdgeInsets.only(
                  bottom: AppMeasurements.paddingLarge,
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppMeasurements.paddingMedium),
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  // Map localized name / message if matching keys exist
                  String displayName = chat.name;
                  String displayMsg = chat.message;
                  String displayTime = chat.time;

                  if (chat.name == 'Sara Ahmed') displayName = local.saraAhmed;

                  if (chat.message == 'Sent a voice message')
                    displayMsg = local.sentVoiceMessage;
                  if (chat.message == 'Thank you, Have anice day')
                    displayMsg = local.thankYouHaveNiceDay;
                  if (chat.message == 'Great I will have a look the te...')
                    displayMsg = local.greatIWillHaveLook;

                  if (chat.time == 'Just Now') displayTime = local.justNow;
                  if (chat.time == '10 min ago') displayTime = local.tenMinAgo;

                  return ChatItemWidget(
                    name: displayName,
                    message: displayMsg,
                    time: displayTime,
                    avatarUrl: chat.avatarUrl,
                    isVoiceMessage: chat.isVoiceMessage,
                    unreadCount: chat.unreadCount,
                    isRead: chat.isRead,
                    onTap: () {
                      context.push(RouteNames.hrChatScreen, extra: chat.id);
                    },
                  );
                },
              );
            },
          );
  }
}
