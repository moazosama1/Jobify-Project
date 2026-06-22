import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view/widgets/messages_screen_view_body.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScreenWrapper(body: MessagesScreenViewBody());
  }
}
