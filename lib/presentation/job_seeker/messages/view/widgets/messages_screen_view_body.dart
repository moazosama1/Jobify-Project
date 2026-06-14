import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/widgets/chat_item_widget.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view_model/messages_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view_model/messages_state.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/router/route_names.dart';

class MessagesScreenViewBody extends StatelessWidget {
  const MessagesScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final local = AppLocalizations.of(context);

    return Column(
      children: [
        // Custom Header Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back Button
            InkWell(
              onTap: () {
                final navigator = Navigator.of(context);
                if (navigator.canPop()) {
                  navigator.pop();
                }
              },
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(AppMeasurements.paddingSmall + 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 20,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            // Title
            Text(
              local.chats,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            // Right Actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.black[50] : AppColors.lightGray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        size: 20,
                        color: theme.colorScheme.onSurface,
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(width: AppMeasurements.paddingSmall),
                IconButton(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: theme.colorScheme.onSurface,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingLarge),
        // Chat List
        Expanded(
          child: BlocBuilder<MessagesCubit, MessagesState>(
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
                      context.push(RouteNames.chatScreen);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
