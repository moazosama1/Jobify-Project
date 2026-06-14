import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/di/di.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view/messages_screen.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view_model/messages_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/messages/view_model/messages_event.dart';
import 'package:jobify_project/presentation/job_seeker/chat_screen/view/screens/chat_screen.dart';
import 'package:jobify_project/presentation/job_seeker/chat_screen/view_model/chat_screen_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/chat_screen/view_model/chat_screen_event.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/home/view_model/home_event.dart';
import 'package:jobify_project/presentation/job_seeker/job_details/view/job_details_screen.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view/profile_screen.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/profile/view_model/profile_event.dart';
import 'package:jobify_project/presentation/job_seeker/saved_jobs/view/saved_jobs_screen.dart';
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
import 'package:jobify_project/presentation/job_seeker/home/view/screens/home_screen.dart';
import 'package:jobify_project/presentation/job_seeker/applications/view/screens/applications_screen.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view/screens/apply_job_screen.dart';
import 'package:jobify_project/presentation/job_seeker/apply_job/view_model/apply_job_cubit.dart';
import 'package:jobify_project/presentation/job_seeker/main_layout/view/screens/main_layout_screen.dart';

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
                  create: (_) =>
                      getIt<HomeCubit>()..doIntent(HomeLoadDataEvent()),
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
                      getIt<MessagesCubit>()..doIntent(MessagesLoadEvent()),
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
                      getIt<ProfileCubit>()..doIntent(const ProfileLoadDataEvent()),
                  child: const ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.applyJob,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ApplyJobCubit>(),
          child: const ApplyJobScreen(),
        ),
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
        builder: (context, state) => const JobDetailsScreen(),
      ),
      GoRoute(
        path: RouteNames.savedJobs,
        builder: (context, state) => const SavedJobsScreen(),
      ),
      GoRoute(
        path: RouteNames.chatScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ChatScreenCubit>()..doIntent(ChatScreenLoadEvent()),
          child: const ChatScreen(),
        ),
      ),
    ],
  );
}
