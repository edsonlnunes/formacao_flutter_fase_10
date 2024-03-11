import 'package:flutter_test/flutter_test.dart';
import 'package:nikel_app/features/splash_screen/views/splash.store.dart';
import 'package:nikel_app/shared/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    Constants.userToken = '';
  });

  group('SplashStore -', () {
    test('Deve retornar false se usuário nao tiver logado', () async {
      final store = SplashStore();

      expect(Constants.userToken, '');

      final result = await store.userIsAuthenticated();

      expect(result, isFalse);
      expect(Constants.userToken, '');
    });

    test('Deve retornar true se usuário tiver logado e preencher o token',
        () async {
      final store = SplashStore();

      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setString('userToken', 'any_token');

      expect(Constants.userToken, '');

      final result = await store.userIsAuthenticated();

      expect(result, isTrue);
      expect(Constants.userToken, 'any_token');
    });
  });
}
