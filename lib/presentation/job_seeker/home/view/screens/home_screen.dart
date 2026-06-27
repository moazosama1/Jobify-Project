import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/home_screen_view_body.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_state.dart';
import 'package:toastification/toastification.dart';

import 'package:jobify_project/core/widgets/draggable_floating_ai_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.actionMessage != current.actionMessage &&
          current.actionMessage != null,
      listener: (context, state) {
        if (state.actionMessage != null) {
          customToastification(
            context,
            state.isActionSuccess
                ? ToastificationType.success
                : ToastificationType.error,
            state.actionMessage,
          );
        }
      },
      child: const CustomScreenWrapper(
        applyPadding: false,
        body: Stack(
          children: [
            Scaffold(
              body: HomeScreenViewBody(),
            ),
            DraggableFloatingAiButton(),
          ],
        ),
      ),
    );
  }
}
