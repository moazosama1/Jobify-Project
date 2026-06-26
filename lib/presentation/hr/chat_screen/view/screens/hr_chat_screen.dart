import 'package:flutter/material.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import '../widgets/hr_chat_screen_body.dart';
import '../widgets/hr_chat_header_section.dart';

class HrChatScreen extends StatelessWidget {
  const HrChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScreenWrapper(
      appBar: HrChatHeaderSection(),
      body: HrChatScreenBody(),
    );
  }
}
