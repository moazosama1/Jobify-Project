import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';

class HrMessageBubble extends StatelessWidget {
  final MessageEntity message;

  const HrMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMe = message.isMe;

    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (message.time.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(
              bottom: AppMeasurements.paddingExtraSmall,
              left: AppMeasurements.paddingSmall,
              right: AppMeasurements.paddingSmall,
            ),
            child: Text(
              message.time,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                fontSize: 11,
              ),
            ),
          ),
        ],
        Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppMeasurements.paddingMedium,
              vertical: AppMeasurements.paddingMedium - 4,
            ),
            decoration: BoxDecoration(
              color: isMe
                  ? theme.colorScheme.primary
                  : (theme.brightness == Brightness.dark
                      ? AppColors.black[50]
                      : const Color(0xFFF8F9FA)),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isMe ? 20 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 20),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.02),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message.text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isMe
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
