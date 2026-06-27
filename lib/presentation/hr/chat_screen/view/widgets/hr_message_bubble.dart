import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/domain/entities/message_entity.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';

class HrMessageBubble extends StatelessWidget {
  final MessageEntity message;

  const HrMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Align(
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
              ? context.primaryColor
              : (context.theme.brightness == Brightness.dark
                  ? const Color(0xFF252A30)
                  : const Color(0xFFE0E9FF)),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: context.theme.shadowColor.withValues(alpha: 0.02),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.end,
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(
              message.text,
              style: context.bodyMedium?.copyWith(
                color: isMe
                    ? context.onPrimaryColor
                    : context.onSurfaceColor,
              ),
            ),
            if (message.time.isNotEmpty)
              Text(
                message.time,
                style: context.bodySmall?.copyWith(
                  color: isMe 
                      ? context.onPrimaryColor.withValues(alpha: 0.7) 
                      : context.onSurfaceColor.withValues(alpha: 0.4),
                  fontSize: 10,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
