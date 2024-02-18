import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nikel_app_base/features/releases/services/get_all_releases.service.dart';
import 'package:nikel_app_base/shared/entities/release.entity.dart';
import 'package:nikel_app_base/utils/app.constants.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final GetAllReleasesService sut;

  setUpAll(() {
    dio = MockDio();
    sut = GetAllReleasesService(dio);
    AppConstants.token = 'any_token';
  });

  tearDown(() => reset(dio));

  group('GetAllReleasesService -', () {
    const route = '${AppConstants.baseUrl}/releases';
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

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) async => Future.value(
          Response(
            data: releasesMap,
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

    test('Deve consumir a rota com sucesso e retornar uma lista de Release',
        () async {
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

      final result = await sut();

      expect(
        result,
        equals(
          [
            Release.fromMap(releasesMap[0]),
            Release.fromMap(releasesMap[1]),
          ],
        ),
      );
    });
  });
}
