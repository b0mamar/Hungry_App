import 'package:dio/dio.dart';
import 'package:hangry_app/core/utiles/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {'Content-Type': 'application/json'},
    ),
  );
  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // You can add authorization headers or logging here
          final token =
              await PrefHelper.getUserToken(); // Retrieve your token from secure storage
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }
  Dio get dio => _dio;
}
