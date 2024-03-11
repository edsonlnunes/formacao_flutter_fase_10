import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/error/custom_exception.dart';
import '../../../../shared/utils/constants.dart';
import '../../dtos/auth.dto.dart';
import '../../services/auth.service.dart';

part 'login.store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  @observable
  bool isLoading = false;

  String? error;

  @action
  Future<void> login({
    required String email,
    required String pass,
  }) async {
    try {
      isLoading = true;
      error = null;

      final service = AuthService(GetIt.I.get());
      final auth = AuthDto(email: email, pass: pass);

      final token = await service.login(auth);

      Constants.userToken = token;

      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setString('userToken', token);
    } on CustomException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }
}
