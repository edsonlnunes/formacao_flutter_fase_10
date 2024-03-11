import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nikel_app/features/releases/views/releases.store.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();

  setUpAll(() {
    GetIt.I.registerSingleton<Dio>(mockDio);
  });

  tearDown(() => reset(mockDio));

  tearDownAll(() {
    GetIt.I.unregister<Dio>();
  });

  group('ReleasesStore', () {
    group('loadWalletBalance', () {
      test('Deve popular o estado do walletBalance corretamente', () async {
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

        final store = ReleasesStore();

        expect(store.error, isNull);
        expect(store.isLoadingBalance, isFalse);
        expect(store.walletBalance, 0);

        await store.loadWalletBalance();

        expect(store.error, isNull);
        expect(store.isLoadingBalance, isFalse);
        expect(store.walletBalance, 29.99);
      });

      test('Deve popular o estado de erro ao buscar o valor da carteira',
          () async {
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

        final store = ReleasesStore();

        expect(store.error, isNull);
        expect(store.isLoadingBalance, isFalse);
        expect(store.walletBalance, 0);

        await store.loadWalletBalance();

        expect(store.error, 'ANY_ERROR');
        expect(store.isLoadingBalance, isFalse);
        expect(store.walletBalance, 0);
      });
    });
  });
}
