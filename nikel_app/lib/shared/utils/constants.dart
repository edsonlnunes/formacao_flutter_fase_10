import 'package:dio/dio.dart';

class Constants {
  static String apiURL =
      'https://77a3-2804-4508-5110-b81-f1cd-de3c-767d-67ff.ngrok-free.app/api';

  static String userToken = '';

  static Options get dioOptions {
    return Options(
      headers: {
        'authorization': 'Bearer $userToken',
      },
    );
  }
}
