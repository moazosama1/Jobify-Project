import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_contact_info_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_header_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_resume_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_experience_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_education_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_personal_info_widget.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/widgets/profile_skills_widget.dart';
import '../../view_model/user_profile_cubit.dart';
import '../../view_model/user_profile_state.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CustomLoadingIndicator());
        }

        final user = state.data;
        if (user == null) {
          if (state.errorMessage != null) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: context.bodyMedium?.copyWith(color: context.errorColor),
              ),
            );
          }
          return const Center(child: Text("No Profile Data"));
        }

        final name = '${user.firstName} ${user.lastName}';
        final title = user.role;
        final skillsString = user.skills.join(', ');

        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppMeasurements.paddingMedium,
            vertical: AppMeasurements.paddingMedium,
          ),
          children: [
            ProfileHeaderWidget(
              name: name,
              title: title,
              bio: user.bio,
              profileImage: user.profileImage,
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            ProfilePersonalInfoWidget(
              age: user.age,
              gender: user.gender,
              location: user.location,
              jobPreferences: user.jobTypePreferences,
            ),
            const SizedBox(height: AppMeasurements.paddingMedium),
            ProfileContactInfoWidget(
              name: name,
              email: user.email,
              phoneNumber: user.phoneNumber,
            ),
            if (user.resume != null && user.resume!.isNotEmpty) ...[
              const SizedBox(height: AppMeasurements.paddingMedium),
              ProfileResumeWidget(
                name: name,
                title: title,
                description: skillsString.isNotEmpty ? 'Skills: $skillsString' : '',
                resumeUrl: user.resume,
              ),
            ],
            if (user.skills.isNotEmpty) ...[
              const SizedBox(height: AppMeasurements.paddingMedium),
              ProfileSkillsWidget(
                skills: user.skills,
              ),
            ],
            if (user.experience.isNotEmpty) ...[
              const SizedBox(height: AppMeasurements.paddingMedium),
              ProfileExperienceWidget(
                experienceList: user.experience,
              ),
            ],
            if (user.education.isNotEmpty) ...[
              const SizedBox(height: AppMeasurements.paddingMedium),
              ProfileEducationWidget(
                educationList: user.education,
              ),
            ],
          ],
        );
      },
    );
  }
}
