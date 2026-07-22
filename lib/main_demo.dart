import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jobify_project/core/constants/const_keys.dart';
import 'package:jobify_project/core/cubit/core_cubit.dart';
import 'package:jobify_project/core/di/di.dart';
import 'package:jobify_project/core/responsive/app_responsive.dart';
import 'package:jobify_project/core/utils/secure_storage_manager.dart';
import 'package:jobify_project/my_bloc_observer.dart';
import 'main.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Safe Firebase Initialization on Web
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization notice: $e');
  }

  await configureDependencies();
  Bloc.observer = MyBlocObserver();

  // Set default demo token and role so web demo starts seamlessly
  final storage = getIt<SecureStorageManager>();
  await storage.setString(key: ConstKeys.kUserToken, value: "mock_jwt_access_token_demo");
  await storage.setString(key: ConstKeys.kRoleKey, value: "JobSeeker");

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    BlocProvider(
      create: (context) => getIt<CoreCubit>(),
      child: const AppResponsive(width: 390, child: MyApp()),
    ),
  );
}
