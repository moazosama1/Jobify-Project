import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/di/di.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/presentation/edit_profile/view_model/edit_profile_event.dart';
import 'package:jobify_project/presentation/hr/chat_screen/view_model/hr_chat_screen_event.dart';
import 'package:jobify_project/presentation/job_seeker/edit_profile/view/screens/edit_profile_screen.dart';
import 'package:jobify_project/presentation/job_seeker/edit_profile/view_model/edit_job_seeker_profile_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view/messages_screen.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view_model/messages_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view_model/messages_event.dart';
import 'package:jobify_project/presentation/job_seeker/chat_screen/view/screens/chat_screen.dart';
import 'package:jobify_project/presentation/job_seeker/chat_screen/view_model/chat_screen_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/chat_screen/view_model/chat_screen_event.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view/job_details_screen.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/profile_screen.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_event.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view/saved_jobs_screen.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view_model/saved_jobs_cubit.dart';
import 'package:jobify_project/presentation/onboarding/view_model/onboarding_cubit.dart';
import 'package:jobify_project/presentation/onboarding/view/screens/onboarding_screen.dart';
import 'package:jobify_project/presentation/splash/view_model/splash_cubit.dart';
import 'package:jobify_project/presentation/splash/view/screens/splash_screen.dart';
import 'package:jobify_project/presentation/auth/login/view/screens/login_screen.dart';
import 'package:jobify_project/presentation/auth/login/view_model/login_cubit.dart';
import 'package:jobify_project/presentation/auth/register/view/screens/register_screen.dart';
import 'package:jobify_project/presentation/auth/register/view_model/register_cubit.dart';
import 'package:jobify_project/presentation/auth/forget_password/view/screens/forget_password_screen.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_cubit.dart';
import 'package:jobify_project/presentation/auth/confirm_email/view/screens/confirm_email_screen.dart';
import 'package:jobify_project/presentation/auth/confirm_email/view_model/confirm_email_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/home/view/screens/home_screen.dart';
import 'package:jobify_project/presentation/job_seeker/applications/view/screens/applications_screen.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view/screens/apply_job_screen.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/main_layout/view/screens/main_layout_screen.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view_model/job_details_cubit.dart';
import 'package:jobify_project/domain/entities/job_entity.dart';

// HR Presentation Layer Imports
import 'package:jobify_project/presentation/hr/main_layout/view/screens/hr_main_layout_screen.dart';
import 'package:jobify_project/presentation/hr/home/view/screens/hr_home_screen.dart';
import 'package:jobify_project/presentation/hr/home/view_model/hr_home_cubit.dart';
import 'package:jobify_project/presentation/hr/home/view_model/hr_home_event.dart';
import 'package:jobify_project/presentation/hr/applications/view/screens/hr_applications_screen.dart';
import 'package:jobify_project/presentation/hr/messages/view/hr_messages_screen.dart';
import 'package:jobify_project/presentation/hr/messages/view_model/hr_messages_cubit.dart';
import 'package:jobify_project/presentation/hr/messages/view_model/hr_messages_event.dart';
import 'package:jobify_project/presentation/hr/profile/view/hr_profile_screen.dart';
import 'package:jobify_project/presentation/hr/profile/view_model/hr_profile_cubit.dart';
import 'package:jobify_project/presentation/hr/profile/view_model/hr_profile_event.dart';
import 'package:jobify_project/presentation/hr/chat_screen/view/screens/hr_chat_screen.dart';
import 'package:jobify_project/presentation/hr/chat_screen/view_model/hr_chat_screen_cubit.dart';
// import 'package:jobify_project/presentation/hr/chat_screen/view_model/hr_chat_screen_event.dart';
import 'package:jobify_project/presentation/hr/hiring_post/view/screens/hr_hiring_post_screen.dart';
import 'package:jobify_project/presentation/hr/hiring_post/view_model/hr_hiring_post_cubit.dart';
import 'package:jobify_project/presentation/hr/job_applications/view/screens/hr_job_applications_screen.dart';
import 'package:jobify_project/presentation/hr/job_applications/view_model/hr_job_applications_cubit.dart';
import 'package:jobify_project/presentation/hr/job_applications/view_model/hr_job_applications_event.dart';
import 'package:jobify_project/presentation/edit_profile/view/screens/edit_profile_screen.dart';
import 'package:jobify_project/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:jobify_project/presentation/search/view/screens/search_screen.dart';
import 'package:jobify_project/presentation/search/view_model/search_cubit.dart';
import 'package:jobify_project/presentation/search/view_model/search_event.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/presentation/ai_chat/view/screens/ai_chat_screen.dart';

abstract class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SplashCubit>(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<OnboardingCubit>(),
          child: const OnboardingScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayoutScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => BlocProvider(
                  create: (_) => getIt<HomeCubit>(),
                  child: const HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.applications,
                builder: (context, state) => const ApplicationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.messages,
                builder: (context, state) => BlocProvider(
                  create: (_) =>
                      getIt<MessagesCubit>()..doIntent(LoadMessagesEvent()),
                  child: const MessagesScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.profile,
                builder: (context, state) => BlocProvider(
                  create: (_) =>
                      getIt<ProfileCubit>()..doIntent(const LoadProfileEvent()),
                  child: const ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HrMainLayoutScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.hrHome,
                builder: (context, state) => BlocProvider(
                  create: (_) =>
                      getIt<HrHomeCubit>()..doIntent(LoadHrHomeEvent()),
                  child: const HrHomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.hrApplications,
                builder: (context, state) => const HrApplicationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.hrMessages,
                builder: (context, state) => BlocProvider(
                  create: (_) =>
                      getIt<HrMessagesCubit>()..doIntent(LoadHrMessagesEvent()),
                  child: const HrMessagesScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.hrProfile,
                builder: (context, state) => BlocProvider(
                  create: (_) =>
                      getIt<HrProfileCubit>()
                        ..doIntent(const LoadHrProfileEvent()),
                  child: const HrProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.applyJob,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final jobId = state.extra as String;
          return BlocProvider(
            create: (_) => getIt<ApplyJobCubit>(),
            child: ApplyJobScreen(jobId: jobId),
          );
        },
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<RegisterCubit>(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.forgetPassword,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ForgetPasswordCubit>(),
          child: const ForgetPasswordScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.jobDetails,
        builder: (context, state) {
          final job = state.extra as JobEntity?;
          return BlocProvider(
            create: (_) => getIt<JobDetailsCubit>(param1: job),
            child: const JobDetailsScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteNames.savedJobs,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SavedJobsCubit>(),
          child: const SavedJobsScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.chatScreen,
        builder: (context, state) {
          final receiverId = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) =>
                getIt<ChatScreenCubit>()
                  ..doIntent(LoadChatScreenEvent(receiverId)),
            child: const ChatScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteNames.hrChatScreen,
        builder: (context, state) {
          final receiverId = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) =>
                getIt<HrChatScreenCubit>()
                  ..doIntent(LoadHrChatScreenEvent(receiverId)),
            child: const HrChatScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteNames.hrHiringPost,
        builder: (context, state) {
          final job = state.extra as JobEntity?;
          return BlocProvider(
            create: (_) => getIt<HrHiringPostCubit>(),
            child: HrHiringPostScreen(job: job),
          );
        },
      ),
      GoRoute(
        path: RouteNames.hrJobApplications,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final jobId = extra['jobId'] as String;
          final jobTitle = extra['jobTitle'] as String;
          return BlocProvider(
            create: (_) =>
                getIt<HrJobApplicationsCubit>()
                  ..doIntent(LoadHrJobApplicationsEvent(jobId)),
            child: HrJobApplicationsScreen(jobTitle: jobTitle),
          );
        },
      ),
      GoRoute(
        path: RouteNames.editProfile,
        builder: (context, state) => BlocProvider(
          create: (_) =>
              getIt<EditProfileCubit>(),
          child: const EditProfileScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.editJobSeekerScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<EditJobSeekerProfileCubit>(),
          child: const EditJobSeekerProfileScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.confirmEmail,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => getIt<ConfirmEmailCubit>(),
            child: ConfirmEmailScreen(email: email),
          );
        },
      ),
      GoRoute(
        path: RouteNames.search,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final initialFilters = state.extra as GetAllJobsRequestEntity?;
          return BlocProvider(
            create: (_) {
              final cubit = getIt<SearchCubit>();
              if (initialFilters != null) {
                cubit.doIntent(UpdateFiltersSearchEvent(initialFilters));
              }
              return cubit;
            },
            child: const SearchScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteNames.aiChat,
        builder: (context, state) => const AiChatScreen(),
      ),
    ],
  );
}
