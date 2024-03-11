import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/error/custom_exception.dart';
import '../../dtos/auth.dto.dart';
import '../../services/auth.service.dart';

part 'register.store.g.dart';

class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  @observable
  bool isLoading = false;

  String? error;

  @action
  Future<void> createAccount({
    required String email,
    required String pass,
  }) async {
    try {
      isLoading = true;
      error = null;
      final service = AuthService(GetIt.I.get());
      final auth = AuthDto(email: email, pass: pass);
      await service.createAccount(auth);
    } on CustomException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }
}
