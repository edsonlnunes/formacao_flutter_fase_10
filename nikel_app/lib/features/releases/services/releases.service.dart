import 'package:dio/dio.dart';

import '../../../shared/error/custom_exception.dart';
import '../../../shared/utils/constants.dart';

class ReleasesService {
  final Dio _dio;

  ReleasesService(this._dio);

  Future<double> getWalletBalance() async {
    try {
      final response = await _dio.get(
        '/releases/wallet-balance',
        options: Constants.dioOptions,
      );

      return response.data;
    } on DioException catch (e) {
      throw CustomException(e.response!.data['error']);
    }
  }
}
