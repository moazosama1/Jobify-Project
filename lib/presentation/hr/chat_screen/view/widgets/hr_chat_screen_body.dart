import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import '../../view_model/hr_chat_screen_cubit.dart';
import '../../view_model/hr_chat_screen_state.dart';
import 'hr_chat_list_section.dart';
import 'hr_chat_input_section.dart';

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
    return BlocBuilder<HrChatScreenCubit, HrChatScreenState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CustomLoadingIndicator());
        }

        if (state.errorMessage != null) {
          return Center(
            child: Text(
              state.errorMessage!,
              style: context.bodyMedium?.copyWith(
                color: context.errorColor,
              ),
            ),
          );
        }

        // Auto scroll on new messages
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

        return Column(
          children: [
            const SizedBox(height: AppMeasurements.paddingMedium),
            // Today Divider
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: context.theme.dividerTheme.color?.withValues(alpha: 0.5) ??
                        context.onSurfaceColor.withValues(alpha: 0.1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppMeasurements.paddingMedium,
                  ),
                  child: Text(
                    context.l10n.today,
                    style: context.bodySmall?.copyWith(
                      color: context.onSurfaceColor.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: context.theme.dividerTheme.color?.withValues(alpha: 0.5) ??
                        context.onSurfaceColor.withValues(alpha: 0.1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            // Chat Message Log List
            Expanded(
              child: HrChatListSection(scrollController: _scrollController),
            ),
            // Bottom Message Entry Bar
            HrChatInputSection(textController: _textController),
          ],
        );
      },
    );
  }
}
