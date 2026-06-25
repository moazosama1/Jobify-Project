import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/presentation/ai_chat/view_model/ai_chat_view_model.dart';
import 'package:jobify_project/presentation/ai_chat/view_model/ai_chat_events.dart';
import 'package:jobify_project/presentation/ai_chat/view_model/ai_chat_state.dart';

class AiChatInputSection extends StatefulWidget {
  const AiChatInputSection({super.key});

  @override
  State<AiChatInputSection> createState() => _AiChatInputSectionState();
}

class _AiChatInputSectionState extends State<AiChatInputSection> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        final file = result.files.single;
        if (mounted) {
          context.read<AiChatViewModel>().doIntent(
            SelectPdfAiChatEvent(file.bytes!, file.name),
          );
        }
      }
    } catch (_) {
      // Fail silently or log error
    }
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    final state = context.read<AiChatViewModel>().state;
    final hasPdf = state.selectedPdfName != null;

    if (text.isNotEmpty || hasPdf) {
      final finalMsg = text.isNotEmpty
          ? text
          : context.l10n.aiChatAnalyzePdfPrompt;
      context.read<AiChatViewModel>().doIntent(
        SendAiChatMessageEvent(finalMsg),
      );
      _textController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiChatViewModel, AiChatState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppMeasurements.paddingMedium,
            AppMeasurements.paddingSmall,
            AppMeasurements.paddingMedium,
            AppMeasurements.paddingMedium,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppMeasurements.paddingSmall,
              vertical: AppMeasurements.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: context.theme.brightness == Brightness.dark 
                  ? context.surfaceColor 
                  : Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: context.primaryColor.withValues(alpha: 0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.primaryColor.withValues(alpha: 0.05),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.selectedPdfName != null) ...[
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: AppMeasurements.paddingSmall,
                      top: 4,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppMeasurements.paddingMedium,
                      vertical: AppMeasurements.paddingSmall,
                    ),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: context.primaryColor.withValues(alpha: 0.15),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.picture_as_pdf_rounded,
                          color: context.primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: AppMeasurements.paddingSmall),
                        Expanded(
                          child: Text(
                            state.selectedPdfName!,
                            style: context.bodyMedium?.copyWith(
                              color: context.onSurfaceColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<AiChatViewModel>().doIntent(
                              const RemoveSelectedPdfAiChatEvent(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: context.onSurfaceColor.withValues(
                                alpha: 0.06,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: 14,
                              color: context.onSurfaceColor.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Row(
                  children: [
                    GestureDetector(
                      onTap: _pickFile,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: context.onSurfaceColor.withValues(alpha: 0.04),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.attach_file_rounded,
                          size: 18,
                          color: context.onSurfaceColor.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppMeasurements.paddingSmall),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        style: context.bodyMedium?.copyWith(
                          color: context.onSurfaceColor,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: context.l10n.aiChatPlaceholder,
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.onSurfaceColor.withValues(
                              alpha: 0.4,
                            ),
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          filled: false,
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: AppMeasurements.paddingSmall),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.primaryColor,
                              context.primaryColor.withValues(alpha: 0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: context.primaryColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
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
              ],
            ),
          ),
        );
      },
    );
  }
}
