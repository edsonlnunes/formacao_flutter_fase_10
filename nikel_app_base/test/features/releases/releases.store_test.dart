import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nikel_app_base/features/releases/releases.store.dart';
import 'package:nikel_app_base/features/releases/services/get_all_releases.service.dart';
import 'package:nikel_app_base/features/releases/services/get_wallet_balance.service.dart';
import 'package:nikel_app_base/shared/entities/release.entity.dart';
import 'package:nikel_app_base/utils/app.constants.dart';

class MockDio extends Mock implements Dio {}

ReleasesStore makeStore(MockDio dio) {
  return ReleasesStore(
    GetAllReleasesService(dio),
    GetWalletBalanceService(dio),
  );
}

void main() {
  late final MockDio dio;

  setUpAll(() => [dio = MockDio(), AppConstants.token = 'any_token']);
  tearDown(() => reset(dio));

  group('ReleasesStore -', () {
    const route = '${AppConstants.baseUrl}/releases';
    const walletRoute = '$route/wallet-balance';
    final releasesMap = [
      {
        'id': 1,
        'value': 15.20,
        'description': 'any_description',
        'date': DateTime.now().toIso8601String(),
        'isInflow': true,
      },
      {
        'id': 2,
        'value': 2.10,
        'description': 'any_description',
        'date': DateTime.now().toIso8601String(),
        'isInflow': false,
      },
    ];

    test('Deve retornar uma listagem de Release', () async {
      final store = makeStore(dio);

      when(
        () => dio.get(walletRoute, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: 10.0,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: releasesMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      await store.getReleases();

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.releasesInflow, [
        Release.fromMap(releasesMap[0]),
      ]);
      expect(store.releasesOutflow, [
        Release.fromMap(releasesMap[1]),
      ]);
    });

    test('Deve preencher estado de failure ao tentar listar as Releases',
        () async {
      final store = makeStore(dio);

      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenThrow(
        DioException(
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
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      await store.getReleases();

      expect(store.isLoading, isFalse);
      expect(store.releasesInflow, []);
      expect(store.releasesOutflow, []);
      expect(store.failure, equals('any_message'));
    });
  });
}
