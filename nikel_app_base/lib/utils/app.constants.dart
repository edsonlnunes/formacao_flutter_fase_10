import 'package:dio/dio.dart';

abstract class AppConstants {
  static const String baseUrl =
      'https://d3d8-2804-4508-5118-3cc1-8d84-8ab6-f24f-1bfe.ngrok-free.app/api';
  static String? token;
  static Map<String, String> get headerApi => {
        'authorization': 'Bearer $token',
      };
  static final dioOptions = Options(headers: AppConstants.headerApi);
}
