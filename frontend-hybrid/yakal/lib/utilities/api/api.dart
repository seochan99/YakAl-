import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as get_x;

Future<Dio> authDio(BuildContext context) async {
  var dio = Dio(BaseOptions(
    baseUrl: '${dotenv.env['YAKAL_SERVER_HOST']}',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ));

  const storage = FlutterSecureStorage();

  dio.interceptors.clear();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        /* Set Access Token to Bearer Auth Header */
        final accessToken = await storage.read(key: 'ACCESS_TOKEN');
        if (accessToken == null) {
          get_x.Get.offAllNamed("/login");
          return;
        }

        options.headers['Authorization'] = 'Bearer $accessToken';

        /* Request Logging */
        if (kDebugMode) {
          print('🛫 [${options.method}] ${options.path} | START');
          print('🔑 [JWT Bearer Token] $accessToken');
        }

        return handler.next(options);
      },
      onResponse:
          (Response response, ResponseInterceptorHandler handler) async {
        /* Response Logging */
        if (kDebugMode) {
          print(
              '🛬 [${response.requestOptions.method}] ${response.requestOptions.path} | SUCCESS (${response.statusCode})');
        }

        return handler.next(response);
      },
      onError: (error, handler) async {
        /* Error Logging */
        if (kDebugMode) {
          print(
              "🚨 [${error.requestOptions.method}] ${error.requestOptions.path} | ERROR : ${error.message}");
        }

        /* Automatic Token Refreshing Logic */
        if (error.response?.statusCode == 401) {
          if (kDebugMode) {
            print("♻️ Token Refresh Occurred!");
          }

          var refreshDio = Dio(BaseOptions(
            baseUrl: '${dotenv.env['YAKAL_SERVER_HOST']}',
            connectTimeout: const Duration(milliseconds: 5000),
            receiveTimeout: const Duration(milliseconds: 3000),
          ));

          refreshDio.interceptors.clear();

          refreshDio.interceptors.add(
            InterceptorsWrapper(
              onError: (error, handler) async {
                if (kDebugMode) {
                  print("🚨️ Token Refresh Failed...");
                }

                if (error.response?.statusCode == 401 ||
                    error.response?.statusCode == 404) {
                  await storage.deleteAll();
                  get_x.Get.offAllNamed("/login");

                  if (!context.mounted) {
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('로그아웃되었습니다.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }

                return handler.next(error);
              },
            ),
          );

          final refreshToken = await storage.read(key: 'REFRESH_TOKEN');
          refreshDio.options.headers['Authorization'] = 'Bearer $refreshToken';

          final refreshResponse = await refreshDio.post('/auth/reissue');

          if (kDebugMode) {
            print("🎉 Token Refresh Successes!");
          }

          final newAccessToken =
              refreshResponse.data["data"]['accessToken']! as String;
          final newRefreshToken =
              refreshResponse.data["data"]['refreshToken']! as String;

          await storage.write(key: 'ACCESS_TOKEN', value: newAccessToken);
          await storage.write(key: 'REFRESH_TOKEN', value: newRefreshToken);

          error.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          final againDio = Dio(BaseOptions(
            baseUrl: '${dotenv.env['YAKAL_SERVER_HOST']}',
            connectTimeout: const Duration(milliseconds: 5000),
            receiveTimeout: const Duration(milliseconds: 3000),
          ));

          final clonedRequest = await againDio.request(
            error.requestOptions.path,
            options: Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers,
            ),
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters,
          );

          return handler.resolve(clonedRequest);
        }
        return handler.next(error);
      },
    ),
  );

  return dio;
}

Future<Dio> authDioWithContext() async {
  var dio = Dio(BaseOptions(
    baseUrl: '${dotenv.env['YAKAL_SERVER_HOST']}',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ));

  const storage = FlutterSecureStorage();

  dio.interceptors.clear();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        /* Set Access Token to Bearer Auth Header */
        final accessToken = await storage.read(key: 'ACCESS_TOKEN');

        if (accessToken == null) {
          get_x.Get.offAllNamed("/login");
          return;
        }

        /* Already Exist Token */
        if (kDebugMode) {
          print('🔑 [Already Exist Token] $accessToken');
        }

        options.headers['Authorization'] = 'Bearer $accessToken';

        /* Request Logging */
        if (kDebugMode) {
          print('🛫 [${options.method}] ${options.path} | START');
        }

        return handler.next(options);
      },
      onResponse:
          (Response response, ResponseInterceptorHandler handler) async {
        /* Response Logging */
        if (kDebugMode) {
          print(
              '🛬 [${response.requestOptions.method}] ${response.requestOptions.path} | SUCCESS (${response.statusCode})');
          print(
              '🛬 [${response.requestOptions.method}] ${response.requestOptions.path} | BODY : ${response.data}');
        }

        return handler.next(response);
      },
      onError: (error, handler) async {
        /* Error Logging */
        if (kDebugMode) {
          print(
              "🚨 [${error.requestOptions.method}] ${error.requestOptions.path} | ERROR : ${error.message}");
        }

        // /* Automatic Token Refreshing Logic */
        if (error.response?.statusCode == 401) {
          if (kDebugMode) {
            print("♻️ Token Refresh Occurred!");
          }

          var refreshDio = Dio(BaseOptions(
            baseUrl: '${dotenv.env['YAKAL_SERVER_HOST']}',
            connectTimeout: const Duration(milliseconds: 5000),
            receiveTimeout: const Duration(milliseconds: 3000),
          ));

          refreshDio.interceptors.clear();

          refreshDio.interceptors.add(
            InterceptorsWrapper(
              onError: (error, handler) async {
                if (kDebugMode) {
                  print("🚨️ Token Refresh Failed...");
                }

                if (error.response?.statusCode == 401 ||
                    error.response?.statusCode == 404) {
                  await storage.deleteAll();
                  get_x.Get.offAllNamed("/login");
                }

                return handler.next(error);
              },
            ),
          );

          final refreshToken = await storage.read(key: 'REFRESH_TOKEN');
          refreshDio.options.headers['Authorization'] = 'Bearer $refreshToken';

          try {
            final refreshResponse = await refreshDio.post('/auth/reissue');

            if (kDebugMode) {
              print("🎉 Token Refresh Successes!");
            }

            final newAccessToken =
                refreshResponse.data["data"]['accessToken']! as String;
            final newRefreshToken =
                refreshResponse.data["data"]['refreshToken']! as String;

            await storage.write(key: 'ACCESS_TOKEN', value: newAccessToken);
            await storage.write(key: 'REFRESH_TOKEN', value: newRefreshToken);

            /* New Token */
            if (kDebugMode) {
              print('🔑 [New Token] $newAccessToken');
            }

            error.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';

            final againDio = Dio(BaseOptions(
              baseUrl: '${dotenv.env['YAKAL_SERVER_HOST']}',
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            ));

            final clonedRequest = await againDio.request(
              error.requestOptions.path,
              options: Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              ),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
            );

            return handler.resolve(clonedRequest);
          } on DioException catch (error) {
            return handler.next(error);
          }
        }
        return handler.next(error);
      },
    ),
  );

  return dio;
}

// 약 코드 토대로 약 이미지 불러오기
Dio kimsDio() {
  String username = dotenv.env['KIMS_SERVER_USERNAME'] ?? "";
  String password = dotenv.env['KIMS_SERVER_PASSWORD'] ?? "";

  final String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  Dio dio = Dio(BaseOptions(
    baseUrl: '${dotenv.env['KIMS_SERVER_HOST']}',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
    headers: {'Content-Type': 'application/json', 'Authorization': basicAuth},
  ));

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        /* Request Logging */
        if (kDebugMode) {
          print('🛫 [${options.method}] ${options.path} | START');
        }

        return handler.next(options);
      },
      onResponse:
          (Response response, ResponseInterceptorHandler handler) async {
        /* Response Logging */
        if (kDebugMode) {
          print(
              '🛬 [${response.requestOptions.method}] ${response.requestOptions.path} | SUCCESS (${response.statusCode})');
        }

        return handler.next(response);
      },
      onError: (error, handler) async {
        /* Error Logging */
        if (kDebugMode) {
          print(
              "🚨 [${error.requestOptions.method}] ${error.requestOptions.path} | ERROR : ${error.message}");
        }

        return handler.next(error);
      },
    ),
  );

  return dio;
}
