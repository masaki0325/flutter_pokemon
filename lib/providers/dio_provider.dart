import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();

  dio.interceptors.add(
    LogInterceptor(
      request: true,
      // リクエストデータをログ出力
      requestBody: true,
      // リクエストボディをログ出力
      responseBody: true,
      // レスポンスボディをログ出力
      responseHeader: false,
      // レスポンスヘッダーのログはオフ
      error: true,
      // エラー情報をログ出力
      logPrint: (obj) {
        if (kDebugMode) {
          print(obj);
        }
      },
    ),
  );

  return dio;
}
