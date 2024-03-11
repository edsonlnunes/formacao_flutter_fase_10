import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nikel_app/features/authentication/views/login/login.store.dart';
import 'package:nikel_app/shared/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();

  setUpAll(() {
    GetIt.I.registerSingleton<Dio>(mockDio);
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    Constants.userToken = '';
    SharedPreferences.setMockInitialValues({});
  });

  tearDownAll(() {
    GetIt.I.unregister<Dio>();
  });

  group('LoginStore -', () {
    test('Deve requisitar a API, fazer o login e salvar o token', () async {
      when(
        () => mockDio.post(
          '/login',
          data: {'email': 'any_email', 'password': 'any_pass'},
        ),
      ).thenAnswer(
        (_) => Future.value(
          Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: 'any_token'),
        ),
      );

      final store = LoginStore();

      expect(store.isLoading, isFalse);
      expect(store.error, isNull);

      await store.login(email: 'any_email', pass: 'any_pass');

      expect(store.isLoading, isFalse);
      expect(store.error, isNull);

      expect(Constants.userToken, 'any_token');

      final sharedPrefs = await SharedPreferences.getInstance();

      expect(sharedPrefs.getString('userToken'), 'any_token');
    });

    test('Deve falhar a requisição e popular o estado de erro', () async {
      when(
        () => mockDio.post(
          '/login',
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

      final store = LoginStore();

      expect(store.isLoading, isFalse);
      expect(store.error, isNull);

      await store.login(email: 'any_email', pass: 'any_pass');

      expect(store.isLoading, isFalse);
      expect(store.error, 'ANY_ERROR');
      expect(Constants.userToken, '');
      final sharedPrefs = await SharedPreferences.getInstance();
      expect(sharedPrefs.getString('userToken'), isNull);
    });
  });
}
