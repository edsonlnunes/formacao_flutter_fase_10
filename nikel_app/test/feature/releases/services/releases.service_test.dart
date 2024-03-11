import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nikel_app/features/releases/services/releases.service.dart';
import 'package:nikel_app/shared/error/custom_exception.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();
  final sut = ReleasesService(mockDio);

  tearDown(() => reset(mockDio));

  group('ReleasesService -', () {
    group('getWalletBalance -', () {
      test('Deve buscar o valor consolidado na API e retornar o mesmo',
          () async {
        when(
          () => mockDio.get(
            '/releases/wallet-balance',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: 29.99,
            ),
          ),
        );

        final result = await sut.getWalletBalance();

        expect(result, 29.99);
      });

      test('Deve retornar um CustomExcpetion quando a requisição falhar',
          () async {
        // give

        when(
          () => mockDio.get(
            '/releases/wallet-balance',
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 400,
              data: {
                'error': 'ANY_ERROR',
              },
            ),
          ),
        );

        // when
        final future = sut.getWalletBalance();

        // then
        expect(
          future,
          throwsA(
            isA<CustomException>().having(
              (error) => error.message,
              'mensagem de erro',
              'ANY_ERROR',
            ),
          ),
        );
      });
    });
  });
}
