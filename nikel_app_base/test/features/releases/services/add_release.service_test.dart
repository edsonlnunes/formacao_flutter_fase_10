import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nikel_app_base/features/releases/services/add_release.service.dart';
import 'package:nikel_app_base/shared/entities/release.entity.dart';
import 'package:nikel_app_base/utils/app.constants.dart';

import '../../../builders/releases/dtos/add_release.dto.builder.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final AddReleaseService sut;

  setUpAll(() {
    dio = MockDio();
    sut = AddReleaseService(dio);
    AppConstants.token = 'any_token';
  });

  tearDown(() => reset(dio));

  group('AddReleaseService -', () {
    final dto = AddReleaseDTOBuilder.init().build();
    const route = '${AppConstants.baseUrl}/releases';
    final releaseMap = {
      'id': 1,
      'value': dto.value,
      'description': dto.description,
      'date': dto.date.toIso8601String(),
      'isInflow': dto.isInflow,
    };

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.post(
          route,
          data: dto.toMap(),
          options: AppConstants.dioOptions,
        ),
      ).thenAnswer(
        (_) async => Future.value(
          Response(
            data: releaseMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      await sut(dto);

      verify(
        () => dio.post(
          route,
          data: dto.toMap(),
          options: AppConstants.dioOptions,
        ),
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
        () => dio.post(
          route,
          data: dto.toMap(),
          options: AppConstants.dioOptions,
        ),
      ).thenThrow(dioException);

      expect(() async => sut(dto), throwsA(dioException));
    });

    test('Deve consumir a rota com sucesso e retornar um Release', () async {
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

      final result = await sut(dto);

      expect(result, equals(Release.fromMap(releaseMap)));
    });
  });
}
