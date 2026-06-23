import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/di/di.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/presentation/ai_chat/view/widgets/ai_chat_view_body.dart';
import 'package:jobify_project/presentation/ai_chat/view_model/ai_chat_view_model.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AiChatViewModel>(
      create: (context) => getIt<AiChatViewModel>(),
      child: const CustomScreenWrapper(
        applyPadding: false,
        body: const AiChatViewBody(),
      ),
    );
  }
}
