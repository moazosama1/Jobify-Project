import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import '../../view_model/chat_screen_cubit.dart';
import '../../view_model/chat_screen_event.dart';

class ChatInputSection extends StatelessWidget {
  final TextEditingController textController;

  const ChatInputSection({
    super.key,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppMeasurements.paddingSmall,
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.attach_file_rounded,
              color: context.onSurfaceColor.withValues(alpha: 0.4),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: context.onSurfaceColor.withValues(alpha: 0.4),
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
                controller: textController,
                style: context.bodyMedium?.copyWith(
                  color: context.onSurfaceColor,
                ),
                decoration: InputDecoration(
                  hintText: context.l10n.typeMessage,
                  hintStyle: context.bodyMedium?.copyWith(
                    color: context.onSurfaceColor.withValues(
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
                    context.read<ChatScreenCubit>().doIntent(
                          SendMessageChatScreenEvent(val),
                        );
                    textController.clear();
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: AppMeasurements.paddingSmall),
          GestureDetector(
            onTap: () {
              final val = textController.text;
              if (val.trim().isNotEmpty) {
                context.read<ChatScreenCubit>().doIntent(
                      SendMessageChatScreenEvent(val),
                    );
                textController.clear();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.send_rounded,
                size: 18,
                color: context.onPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
