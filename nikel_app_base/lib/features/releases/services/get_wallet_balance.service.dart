import 'package:dio/dio.dart';

import '../../../utils/app.constants.dart';

class GetWalletBalanceService {
  final Dio dio;

  GetWalletBalanceService(this.dio);

  Future<double> call() async {
    final response = await dio.get(
      '${AppConstants.baseUrl}/releases/wallet-balance',
      options: AppConstants.dioOptions,
    );

    return response.data is int ? response.data.toDouble() : response.data;
  }
}
