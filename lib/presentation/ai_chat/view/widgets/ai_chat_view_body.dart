import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/domain/entities/ai_chat_message_entity.dart';
import 'package:jobify_project/presentation/ai_chat/view_model/ai_chat_view_model.dart';
import 'package:jobify_project/presentation/ai_chat/view_model/ai_chat_events.dart';
import 'package:jobify_project/presentation/ai_chat/view_model/ai_chat_state.dart';
import 'ai_chat_message_bubble.dart';
import 'ai_chat_input_section.dart';

class AiChatViewBody extends StatefulWidget {
  const AiChatViewBody({super.key});

  @override
  State<AiChatViewBody> createState() => _AiChatViewBodyState();
}

class _AiChatViewBodyState extends State<AiChatViewBody> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
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
    return BlocBuilder<AiChatViewModel, AiChatState>(
      builder: (context, state) {
        final messages = state.chatMessages.data ?? [];

        // Auto-scroll on list update
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

        final isChatMode = messages.isNotEmpty || state.chatMessages.isLoading;

        if (isChatMode) {
          return Column(
            children: [
              Expanded(child: _buildChatContent(context, state, messages)),
              const AiChatInputSection(),
            ],
          );
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMeasurements.paddingLarge,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    _buildHeroSection(context),
                    const SizedBox(height: 32),
                    const AiChatInputSection(),
                    const SizedBox(height: 32),
                    _buildSuggestionsGrid(context),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: context.primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: context.primaryColor.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
          child: Text(
            context.l10n.aiChatIntelligence,
            style: context.labelSmall?.copyWith(
              color: context.primaryColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 9,
            ),
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.primaryColor.withValues(alpha: 0.2),
                context.primaryColor.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.primaryColor.withValues(alpha: 0.15),
                blurRadius: 24,
                spreadRadius: 4,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: context.primaryColor.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Icon(
            Icons.auto_awesome,
            size: 40,
            color: context.primaryColor,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        Text(
          context.l10n.aiChatHeroTitle,
          style: context.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: context.onSurfaceColor,
            fontSize: 28,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        Text(
          context.l10n.aiChatHeroSubtitle,
          textAlign: TextAlign.center,
          style: context.bodyMedium?.copyWith(
            color: context.onSurfaceColor.withValues(alpha: 0.6),
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionsGrid(BuildContext context) {
    final suggestions = [
      context.l10n.aiChatSuggestionResume,
      context.l10n.aiChatSuggestionInterview,
      context.l10n.aiChatSuggestionSkills,
      context.l10n.aiChatSuggestionCareer,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: AppMeasurements.paddingSmall + 2),
          child: Text(
            context.l10n.aiChatSuggestedTopics,
            style: context.labelSmall?.copyWith(
              color: context.onSurfaceColor.withValues(alpha: 0.4),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              fontSize: 10,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _SuggestionCard(
                text: suggestions[0],
                onTap: () => _sendSuggestion(context, suggestions[0]),
              ),
            ),
            const SizedBox(width: AppMeasurements.paddingMedium),
            Expanded(
              child: _SuggestionCard(
                text: suggestions[1],
                onTap: () => _sendSuggestion(context, suggestions[1]),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        Row(
          children: [
            Expanded(
              child: _SuggestionCard(
                text: suggestions[2],
                onTap: () => _sendSuggestion(context, suggestions[2]),
              ),
            ),
            const SizedBox(width: AppMeasurements.paddingMedium),
            Expanded(
              child: _SuggestionCard(
                text: suggestions[3],
                onTap: () => _sendSuggestion(context, suggestions[3]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _sendSuggestion(BuildContext context, String text) {
    context.read<AiChatViewModel>().doIntent(SendAiChatMessageEvent(text));
  }

  Widget _buildChatContent(
    BuildContext context,
    AiChatState state,
    List<AiChatMessageEntity> messages,
  ) {
    if (state.chatMessages.isLoading && messages.isEmpty) {
      return const Center(child: CustomLoadingIndicator());
    }

    final isSending = state.sendMessageStatus.isLoading;

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(
        vertical: AppMeasurements.paddingMedium,
      ),
      itemCount: messages.length + (isSending ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == messages.length) {
          return const _AnimatedTypingIndicator();
        }
        return AiChatMessageBubble(message: messages[index]);
      },
    );
  }
}

class _AnimatedTypingIndicator extends StatefulWidget {
  const _AnimatedTypingIndicator();

  @override
  State<_AnimatedTypingIndicator> createState() => _AnimatedTypingIndicatorState();
}

class _AnimatedTypingIndicatorState extends State<_AnimatedTypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppMeasurements.paddingMedium,
        vertical: AppMeasurements.paddingSmall,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: context.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.auto_awesome,
              size: 18,
              color: context.primaryColor,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppMeasurements.paddingMedium,
              vertical: AppMeasurements.paddingSmall + 6,
            ),
            decoration: BoxDecoration(
              color: context.primaryColor.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: SizedBox(
              width: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final delay = index * 0.2;
                      double t = (_controller.value - delay);
                      if (t < 0) t += 1.0;

                      double offsetVal;
                      if (t < 0.2) {
                        offsetVal = t / 0.2;
                      } else if (t < 0.4) {
                        offsetVal = 1 - ((t - 0.2) / 0.2);
                      } else {
                        offsetVal = 0.0;
                      }

                      return Transform.translate(
                        offset: Offset(0, -4 * offsetVal),
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: context.primaryColor.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _SuggestionCard({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: context.onSurfaceColor.withValues(alpha: 0.03),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: context.onSurfaceColor.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: context.primaryColor.withValues(alpha: 0.06),
        highlightColor: context.primaryColor.withValues(alpha: 0.03),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingMedium,
            vertical: AppMeasurements.paddingLarge + 4,
          ),
          child: Text(
            text,
            style: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.onSurfaceColor,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
