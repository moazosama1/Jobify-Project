import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/core/widgets/custom_toastification.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_header_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_personal_info_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_contact_info_widget.dart';
import '../../view_model/hr_profile_cubit.dart';
import '../../view_model/hr_profile_event.dart';
import '../../view_model/hr_profile_state.dart';
import 'package:toastification/toastification.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/router/route_names.dart';

class HrProfileScreenViewBody extends StatelessWidget {
  const HrProfileScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HrProfileCubit, HrProfileState>(
      listenWhen: (previous, current) =>
          previous.logoutSuccess != current.logoutSuccess ||
          previous.profileState.errorMessage != current.profileState.errorMessage,
      listener: (context, state) {
        if (state.logoutSuccess) {
          customToastification(
            context,
            ToastificationType.success,
            context.l10n.success,
          );
          context.go(RouteNames.login);
        } else if (state.profileState.errorMessage != null && !state.profileState.isLoading) {
          customToastification(
            context,
            ToastificationType.error,
            state.profileState.errorMessage!,
          );
        }
      },
      builder: (context, state) {
        if (state.profileState.isLoading) {
          return const Center(child: CustomLoadingIndicator());
        }

        final user = state.profileState.data;

        if (state.profileState.errorMessage != null && user == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off_outlined,
                  size: 64,
                  color: context.onSurfaceColor.withValues(alpha: 0.3),
                ),
                const SizedBox(height: AppMeasurements.paddingMedium),
                Text(
                  state.profileState.errorMessage!,
                  style: context.bodyLarge?.copyWith(
                    color: context.onSurfaceColor.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        final name = user != null ? '${user.firstName} ${user.lastName}' : '';
        final email = user?.email ?? '';
        final phoneNumber = user?.phoneNumber ?? '';
        final title = user?.role ?? '';
        final bio = user?.bio ?? '';

        return RefreshIndicator(
          color: context.primaryColor,
          backgroundColor: context.surfaceColor,
          onRefresh: () async {
            context.read<HrProfileCubit>().doIntent(const LoadHrProfileEvent());
            await Future.delayed(const Duration(milliseconds: 800));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header (Avatar, Name, Role, Bio) ──
                ProfileHeaderWidget(
                  name: name,
                  title: title,
                  bio: bio,
                  profileImage: user?.profileImage,
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),

                // ── Personal Info (Age, Gender, Location) ──
                ProfilePersonalInfoWidget(
                  age: user?.age ?? 0,
                  gender: user?.gender ?? '',
                  location: user?.location ?? '',
                  jobPreferences: const [], // Empty for HR
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),

                // ── Contact Info (Name, Email, Phone) ──
                ProfileContactInfoWidget(
                  name: name,
                  email: email,
                  phoneNumber: phoneNumber,
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),

                // ── Logout Button ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButtonLoading(
                      isLoading: state.isLogoutLoading,
                      widthButton: 120,
                      textButton: context.l10n.logout,
                      colorButton: context.errorColor,
                      onPressed: () {
                        context.read<HrProfileCubit>().doIntent(
                              const LogoutHrProfileEvent(),
                            );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppMeasurements.paddingLarge),
              ],
            ),
          ),
        );
      },
    );
  }
}