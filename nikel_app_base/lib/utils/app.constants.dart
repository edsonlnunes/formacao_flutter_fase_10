import 'package:dio/dio.dart';

abstract class AppConstants {
  static const String baseUrl =
      'https://47cf-2804-4508-511b-cf81-f0d3-2b17-4da-1a27.ngrok-free.app/api';
  static String? token;
  static Map<String, String> get headerApi => {
        'authorization': 'Bearer $token',
      };
  static final dioOptions = Options(headers: AppConstants.headerApi);
}
