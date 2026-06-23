import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/domain/entities/ai_chat_message_entity.dart';

class AiChatMessageBubble extends StatefulWidget {
  final AiChatMessageEntity message;

  const AiChatMessageBubble({super.key, required this.message});

  @override
  State<AiChatMessageBubble> createState() => _AiChatMessageBubbleState();
}

class _AiChatMessageBubbleState extends State<AiChatMessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.08), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _hasPdfAttachment() {
    return widget.message.isUser &&
        widget.message.text.startsWith('📄 **') &&
        widget.message.text.contains('.pdf**');
  }

  Map<String, String> _parseMessageWithPdf() {
    try {
      final startIndex = widget.message.text.indexOf('📄 **') + 4;
      final endIndex = widget.message.text.indexOf('.pdf**') + 4;
      final fileName = widget.message.text.substring(startIndex, endIndex);

      final promptStart = widget.message.text.indexOf('\n\n', endIndex);
      final prompt = promptStart != -1
          ? widget.message.text.substring(promptStart + 2).trim()
          : '';

      return {'fileName': fileName, 'prompt': prompt};
    } catch (_) {
      return {'fileName': 'Document.pdf', 'prompt': widget.message.text};
    }
  }

  Widget _buildPdfAttachmentCard(BuildContext context, String fileName) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppMeasurements.paddingSmall + 2),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.picture_as_pdf_rounded,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: AppMeasurements.paddingSmall),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "PDF Document",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isUser = widget.message.isUser;
    final hasPdf = _hasPdfAttachment();

    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingMedium,
            vertical: AppMeasurements.paddingSmall,
          ),
          child: Column(
            crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (!isUser) ...[
                    Container(
                      width: 32,
                      height: 32,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: context.primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.smart_toy_outlined,
                        size: 18,
                        color: context.primaryColor,
                      ),
                    ),
                  ],
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppMeasurements.paddingMedium,
                        vertical: AppMeasurements.paddingSmall + 4,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width * 0.72,
                      ),
                      decoration: BoxDecoration(
                        color: isUser
                            ? context.primaryColor
                            : context.primaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                          bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                        ),
                      ),
                      child: hasPdf
                          ? Builder(
                              builder: (context) {
                                final parsed = _parseMessageWithPdf();
                                final fileName = parsed['fileName'] ?? 'document.pdf';
                                final prompt = parsed['prompt'] ?? '';

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildPdfAttachmentCard(context, fileName),
                                    if (prompt.isNotEmpty) ...[
                                      MarkdownBody(
                                        data: prompt,
                                        styleSheet: MarkdownStyleSheet(
                                          p: context.bodyMedium?.copyWith(
                                            color: isUser
                                                ? context.onPrimaryColor
                                                : context.onSurfaceColor,
                                            fontSize: 14,
                                            height: 1.4,
                                          ),
                                          listBullet: context.bodyMedium?.copyWith(
                                            color: isUser
                                                ? context.onPrimaryColor
                                                : context.onSurfaceColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            )
                          : MarkdownBody(
                              data: widget.message.text,
                              styleSheet: MarkdownStyleSheet(
                                p: context.bodyMedium?.copyWith(
                                  color: isUser ? context.onPrimaryColor : context.onSurfaceColor,
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                                listBullet: context.bodyMedium?.copyWith(
                                  color: isUser ? context.onPrimaryColor : context.onSurfaceColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: isUser ? 0 : 40,
                  right: isUser ? 4 : 0,
                  top: 4,
                ),
                child: Text(
                  widget.message.time,
                  style: context.labelSmall?.copyWith(
                    color: context.onSurfaceColor.withValues(alpha: 0.4),
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

