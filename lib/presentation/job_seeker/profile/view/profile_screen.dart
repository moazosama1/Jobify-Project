import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/core/widgets/custom_app_bar.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_screen_view_body.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_event.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenWrapper(
      appBar: CustomAppBar(
        title: context.l10n.profile,
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () async {
              await context.push(RouteNames.editJobSeekerScreen);
              if (context.mounted) {
                context.read<ProfileCubit>().doIntent(const LoadProfileEvent());
              }
            },
            icon: Icon(Icons.edit_outlined, color: context.onSurfaceColor),
          ),
        ],
      ),
      body: const ProfileScreenViewBody(),
    );
  }
}
