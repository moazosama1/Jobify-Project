import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/di/di.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/presentation/ai_chat/view/widgets/ai_chat_view_body.dart';
import 'package:jobify_project/presentation/ai_chat/view_model/ai_chat_events.dart';
import 'package:jobify_project/presentation/ai_chat/view_model/ai_chat_state.dart';
import 'package:jobify_project/presentation/ai_chat/view_model/ai_chat_view_model.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  void _showClearConfirmation(BuildContext context, AiChatViewModel viewModel) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(context.l10n.clearChat),
        content: Text(context.l10n.aiChatClearConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text(context.l10n.no),
          ),
          TextButton(
            onPressed: () {
              viewModel.doIntent(const ClearAiChatHistoryEvent());
              Navigator.pop(dialogCtx);
            },
            child: Text(context.l10n.yes),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AiChatViewModel>(
      create: (context) => getIt<AiChatViewModel>(),
      child: Builder(
        builder: (context) {
          final viewModel = context.read<AiChatViewModel>();
          return BlocBuilder<AiChatViewModel, AiChatState>(
            builder: (context, state) {
              final hasMessages = state.chatMessages.data?.isNotEmpty == true;
              return CustomScreenWrapper(
                applyPadding: false,
                appBar: CustomAppBar(
                  title: context.l10n.aiChatTitle,
                  actions: [
                    if (hasMessages)
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: context.errorColor,
                        ),
                        onPressed: () => _showClearConfirmation(context, viewModel),
                      ),
                  ],
                ),
                body: const AiChatViewBody(),
              );
            },
          );
        },
      ),
    );
  }
}
