import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/widgets/home_screen_view_body.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_state.dart';
import 'package:toastification/toastification.dart';

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
      child: CustomScreenWrapper(
        applyPadding: false,
        body: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
              bottom: 70.0,
            ), // Float above bottom navigation bar
            child: FloatingActionButton(
              onPressed: () => context.push(RouteNames.aiChat),
              backgroundColor: Colors.white,
              elevation: 8,
              hoverElevation: 12,
              highlightElevation: 4,
              splashColor: context.primaryColor.withValues(alpha: 0.1),
              shape: CircleBorder(
                side: BorderSide(color: context.primaryColor, width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(AppImages.iconAI, fit: BoxFit.contain),
              ),
            ),
          ),
          body: const HomeScreenViewBody(),
        ),
      ),
    );
  }
}
