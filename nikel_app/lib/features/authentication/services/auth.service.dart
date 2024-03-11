import 'package:dio/dio.dart';

import '../../../shared/error/custom_exception.dart';
import '../dtos/auth.dto.dart';

class AuthService {
  final Dio _dio;
  AuthService(this._dio);

  Future<void> createAccount(AuthDto dto) async {
    try {
      await _dio.post(
        '/register',
        data: dto.toMap(),
      );
    } on DioException catch (e) {
      throw CustomException(e.response!.data['error']);
    }
  }

  Future<String> login(AuthDto dto) async {
    try {
      final response = await _dio.post('/login', data: dto.toMap());
      return response.data;
    } on DioException catch (e) {
      throw CustomException(e.response!.data['error']);
    }
  }
}
