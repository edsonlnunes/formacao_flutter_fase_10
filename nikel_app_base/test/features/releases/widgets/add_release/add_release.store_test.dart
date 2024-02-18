import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nikel_app_base/features/releases/services/add_release.service.dart';
import 'package:nikel_app_base/features/releases/widgets/add_release/add_release.store.dart';
import 'package:nikel_app_base/utils/app.constants.dart';

import '../../../../builders/releases/dtos/add_release.dto.builder.dart';

class MockDio extends Mock implements Dio {}

AddReleaseStore makeStore(MockDio dio) {
  return AddReleaseStore(AddReleaseService(dio));
}

void main() {
  late final MockDio dio;

  setUpAll(() => [dio = MockDio(), AppConstants.token = 'any_token']);
  tearDown(() => reset(dio));

  group('AddReleaseStore -', () {
    const route = '${AppConstants.baseUrl}/releases';
    final dto = AddReleaseDTOBuilder.init().build();
    final releaseMap = {
      'id': 1,
      'value': dto.value,
      'description': dto.description,
      'date': dto.date.toIso8601String(),
      'isInflow': dto.isInflow,
    };

    test('Deve adicionar uma Release na listagem', () async {
      final store = makeStore(dio);

      when(
        () => dio.post(
          route,
          data: dto.toMap(),
          options: AppConstants.dioOptions,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: releaseMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      await store.addRelease(
        value: dto.value,
        description: dto.description,
        date: dto.date,
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
    });

    test('Deve preencher estado de failure ao tentar adicionar uma Release',
        () async {
      final store = makeStore(dio);

      when(
        () => dio.post(
          route,
          data: dto.toMap(),
          options: AppConstants.dioOptions,
        ),
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

      await store.addRelease(
        value: dto.value,
        description: dto.description,
        date: dto.date,
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, equals('any_message'));
    });
  });
}
