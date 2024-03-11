import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nikel_app/features/authentication/dtos/auth.dto.dart';
import 'package:nikel_app/features/authentication/services/auth.service.dart';
import 'package:nikel_app/shared/error/custom_exception.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();
  final sut = AuthService(mockDio);
  final dataDto = AuthDto(email: 'any@any.com', pass: 'any');

  setUp(() => reset(mockDio));

  group('AuthService -', () {
    group('createAccount -', () {
      test('Deve requisitar a API com sucesso', () async {
        // give

        when(
          () => mockDio.post(
            '/register',
            data: dataDto.toMap(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
            ),
          ),
        );

        // when
        // then
        expect(sut.createAccount(dataDto), isA<void>());
      });

      test('Deve retornar um CustomExcpetion quando a requisição falhar',
          () async {
        // give

        when(
          () => mockDio.post(
            '/register',
            data: dataDto.toMap(),
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
        final future = sut.createAccount(dataDto);
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

    group('login -', () {
      test('Deve requisitar a API com sucesso', () async {
        // give

        when(
          () => mockDio.post(
            '/login',
            data: dataDto.toMap(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: 'any_token'),
          ),
        );

        // when
        final token = await sut.login(dataDto);

        // then
        expect(token, 'any_token');
      });

      test('Deve retornar um CustomExcpetion quando a requisição falhar',
          () async {
        // give

        when(
          () => mockDio.post(
            '/login',
            data: dataDto.toMap(),
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
        final future = sut.login(dataDto);

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
