import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/widgets/custom_cached_network_image.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';
import '../../view_model/hr_chat_screen_cubit.dart';
import '../../view_model/hr_chat_screen_event.dart';
import '../../view_model/hr_chat_screen_state.dart';
import 'hr_message_bubble.dart';
import 'package:jobify_project/generated/l10n.dart';

class HrChatScreenBody extends StatefulWidget {
  const HrChatScreenBody({super.key});

  @override
  State<HrChatScreenBody> createState() => _HrChatScreenBodyState();
}

class _HrChatScreenBodyState extends State<HrChatScreenBody> {
  late TextEditingController _textController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final local = AppLocalizations.of(context);

    return BlocBuilder<HrChatScreenCubit, HrChatScreenState>(
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

        // Auto scroll on new messages
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

        String displayParticipantName = state.participantName;
        if (state.participantName == 'Mazen Mohammed') {
          displayParticipantName = local.mazenMohammed;
        }

        return Column(
          children: [
            // Custom App Bar Header Row
            Row(
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
                const SizedBox(width: AppMeasurements.paddingMedium),
                // Participant Avatar
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CustomCachedNetworkImage(
                    imageUrl: state.participantAvatar.isNotEmpty
                        ? state.participantAvatar
                        : 'https://i.pravatar.cc/150?img=12',
                    borderRadius: BorderRadius.circular(22),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: AppMeasurements.paddingSmall + 2),
                // Name & Typing status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        displayParticipantName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        state.statusText == 'is typing...'
                            ? local.isTyping
                            : state.statusText,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                // Call Actions
                IconButton(
                  icon: Icon(
                    Icons.phone_outlined,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.videocam_outlined,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            // Today Divider
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: theme.dividerTheme.color?.withValues(alpha: 0.5) ??
                        theme.colorScheme.onSurface.withValues(alpha: 0.1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppMeasurements.paddingMedium,
                  ),
                  child: Text(
                    local.today,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: theme.dividerTheme.color?.withValues(alpha: 0.5) ??
                        theme.colorScheme.onSurface.withValues(alpha: 0.1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            // Chat Message Log List
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                itemCount: state.messages.length,
                padding: const EdgeInsets.only(
                  bottom: AppMeasurements.paddingMedium,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: AppMeasurements.paddingSmall + 2,
                ),
                itemBuilder: (context, index) {
                  final message = state.messages[index];
                  // Localize content if matching
                  String displayTxt = message.text;
                  String displayTime = message.time;

                  if (message.text == 'Halo, bro') displayTxt = local.haloBro;
                  if (message.text == "What's going on? Why do we have no money at all?") {
                    displayTxt = local.whatsGoingOn;
                  }
                  if (message.text == 'so, why should i buy them...') {
                    displayTxt = local.whyShouldIBuy;
                  }

                  if (message.time == '08:50 AM') displayTime = local.time850;
                  if (message.time == '09:01 AM') displayTime = local.time901;
                  if (message.time == '09:20 AM') displayTime = local.time920;

                  return HrMessageBubble(
                    message: MessageEntity(
                      id: message.id,
                      text: displayTxt,
                      time: displayTime,
                      isMe: message.isMe,
                    ),
                  );
                },
              ),
            ),
            // Bottom Message Entry Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppMeasurements.paddingSmall,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.attach_file_rounded,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.black[50] : AppColors.lightGray,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppMeasurements.paddingMedium,
                      ),
                      child: TextField(
                        controller: _textController,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: local.typeMessage,
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.4,
                            ),
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: AppMeasurements.paddingSmall + 2,
                          ),
                          filled: false,
                        ),
                        onSubmitted: (val) {
                          if (val.trim().isNotEmpty) {
                            context.read<HrChatScreenCubit>().doIntent(
                                  HrChatScreenSendMessageEvent(val),
                                );
                            _textController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: AppMeasurements.paddingSmall),
                  GestureDetector(
                    onTap: () {
                      final val = _textController.text;
                      if (val.trim().isNotEmpty) {
                        context.read<HrChatScreenCubit>().doIntent(
                              HrChatScreenSendMessageEvent(val),
                            );
                        _textController.clear();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        size: 18,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
