import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nikel_app_base/features/releases/services/get_wallet_balance.service.dart';
import 'package:nikel_app_base/utils/app.constants.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final GetWalletBalanceService sut;

  setUpAll(() {
    dio = MockDio();
    sut = GetWalletBalanceService(dio);
    AppConstants.token = 'any_token';
  });

  tearDown(() => reset(dio));

  group('GetWalletBalanceService -', () {
    const route = '${AppConstants.baseUrl}/releases/wallet-balance';
    const value = 10.50;

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) async => Future.value(
          Response(
            data: value,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      await sut();

      verify(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).called(1);
    });

    test('Deve ser lançado um erro, caso seja retornado pela chamada da rota',
        () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'success': false,
            'code': 500,
            'error': 'any_message',
          },
          statusCode: 500,
        ),
      );

      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenThrow(dioException);

      expect(() async => sut(), throwsA(dioException));
    });

    test('Deve consumir a rota com sucesso e retornar um double', () async {
      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: value,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      final result = await sut();

      expect(result, equals(value));
    });
  });
}
