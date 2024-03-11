import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nikel_app/features/authentication/views/register/register.store.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();

  setUpAll(() {
    GetIt.I.registerSingleton<Dio>(mockDio);
  });

  tearDownAll(() {
    GetIt.I.unregister<Dio>();
  });

  group('RegisterStore -', () {
    test('Deve chamar o service e não retornar nenhum erro', () async {
      when(
        () => mockDio.post(
          '/register',
          data: {'email': 'any', 'password': 'any'},
        ),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      final store = RegisterStore();

      expect(store.isLoading, isFalse);
      expect(store.error, isNull);

      await store.createAccount(email: 'any', pass: 'any');

      expect(store.isLoading, isFalse);
      expect(store.error, isNull);
    });

    test('Deve chamar o service e popular a mensagem de error', () async {
      when(
        () => mockDio.post(
          '/register',
          data: any(named: 'data'),
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

      final store = RegisterStore();

      expect(store.isLoading, isFalse);
      expect(store.error, isNull);

      await store.createAccount(email: 'any', pass: 'any');

      expect(store.isLoading, isFalse);
      expect(store.error, 'ANY_ERROR');
    });
  });
}
