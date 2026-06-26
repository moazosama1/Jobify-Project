import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/widgets/custom_chat_app_bar.dart';
import '../../view_model/hr_chat_screen_cubit.dart';
import '../../view_model/hr_chat_screen_state.dart';

class HrChatHeaderSection extends StatelessWidget implements PreferredSizeWidget {
  const HrChatHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HrChatScreenCubit, HrChatScreenState>(
      buildWhen: (previous, current) =>
          previous.participantName != current.participantName ||
          previous.participantAvatar != current.participantAvatar ||
          previous.statusText != current.statusText,
      builder: (context, state) {
        String displayParticipantName = state.participantName;
        if (state.participantName == 'Mazen Mohammed') {
          displayParticipantName = context.l10n.mazenMohammed;
        }

        return CustomChatAppBar(
          participantName: displayParticipantName,
          participantAvatar: state.participantAvatar,
          statusText: state.statusText == 'is typing...'
              ? context.l10n.isTyping
              : state.statusText,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}
