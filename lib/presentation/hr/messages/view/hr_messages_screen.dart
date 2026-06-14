import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'widgets/hr_messages_screen_view_body.dart';

class HrMessagesScreen extends StatelessWidget {
  const HrMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScreenWrapper(body: HrMessagesScreenViewBody());
  }
}
