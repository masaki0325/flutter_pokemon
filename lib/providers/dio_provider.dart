import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider<Dio>((ref) => createDio());

Dio createDio() {
  final dio = Dio();

  dio.interceptors.add(LogInterceptor(
    request: true, // リクエストデータをログ出力
    requestBody: true, // リクエストボディをログ出力
    responseBody: true, // レスポンスボディをログ出力
    responseHeader: false, // レスポンスヘッダーのログはオフ
    error: true, // エラー情報をログ出力
    logPrint: (obj) => print(obj), // 出力方法（printでコンソールに出力）
  ));

  return dio;
}
