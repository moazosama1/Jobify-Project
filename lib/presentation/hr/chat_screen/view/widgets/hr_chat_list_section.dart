import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/extensions/string_extension.dart';
import '../../view_model/hr_chat_screen_cubit.dart';
import '../../view_model/hr_chat_screen_state.dart';
import 'hr_message_bubble.dart';

class HrChatListSection extends StatelessWidget {
  final ScrollController scrollController;

  const HrChatListSection({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HrChatScreenCubit, HrChatScreenState>(
      builder: (context, state) {
        return ListView.separated(
          controller: scrollController,
          itemCount: state.data?.length ?? 0,
          padding: const EdgeInsets.only(
            bottom: AppMeasurements.paddingMedium,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: AppMeasurements.paddingSmall + 2,
          ),
          itemBuilder: (context, index) {
            final message = state.data![index];
            // Localize content if matching
            String displayTxt = message.text;
            String displayTime = message.time;

            if (message.text == 'Halo, bro') displayTxt = context.l10n.haloBro;
            if (message.text == "What's going on? Why do we have no money at all?") {
              displayTxt = context.l10n.whatsGoingOn;
            }
            if (message.text == 'so, why should i buy them...') {
              displayTxt = context.l10n.whyShouldIBuy;
            }

            // Fallback for dummy time data or use modern formatting
            if (message.time == '08:50 AM') displayTime = context.l10n.time850;
            else if (message.time == '09:01 AM') displayTime = context.l10n.time901;
            else if (message.time == '09:20 AM') displayTime = context.l10n.time920;
            else displayTime = message.time.toModernChatTime(context);

            return HrMessageBubble(
              message: MessageEntity(
                id: message.id,
                text: displayTxt,
                time: displayTime,
                isMe: message.isMe,
              ),
            );
          },
        );
      },
    );
  }
}
