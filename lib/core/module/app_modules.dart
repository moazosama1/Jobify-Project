import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/mock/mock_api_interceptor.dart';
import '../constants/const_keys.dart';
import '../constants/end_points.dart';
import '../utils/secure_storage_manager.dart';

@module
abstract class AppModules {
  @preResolve
  @lazySingleton
  Future<Dio> provideDio(SecureStorageManager storageManager) async {
    final dio = Dio(provideBaseOptions(EndPoints.baseUrl));
    if (kIsWeb) {
      dio.interceptors.add(MockApiInterceptor());
    }
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String? token = await storageManager.getString(
            key: ConstKeys.kUserToken,
          );
          if (token?.isNotEmpty ?? false) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
      providePrettyDioLogger,
    ]);
    return dio;
  }

  @lazySingleton
  FlutterSecureStorage get provideSecureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @preResolve
  @lazySingleton
  Future<SharedPreferences> provideSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  BaseOptions provideBaseOptions(String baseUrl) {
    return BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
    );
  }

  PrettyDioLogger get providePrettyDioLogger => PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 90,
    enabled: kDebugMode,
  );
}
