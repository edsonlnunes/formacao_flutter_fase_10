import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import '../../dtos/account.dto.dart';
import '../../../../utils/app.constants.dart';

import '../../services/login.service.dart';

part 'login.store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final LoginService _loginService;

  LoginStoreBase(this._loginService);

  @observable
  bool isLoading = false;

  @observable
  String? failure;

  @action
  clearFailure() => failure = null;

  @action
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    clearFailure();
    isLoading = true;

    try {
      final tempToken = await _loginService(
        AccountDTO(email: email, password: password),
      );

      AppConstants.token = tempToken;
      isLoading = false;

      return true;
    } on DioException catch (err) {
      final message = err.response?.data['error'];

      failure = message;
      isLoading = false;

      return false;
    }
  }
}
