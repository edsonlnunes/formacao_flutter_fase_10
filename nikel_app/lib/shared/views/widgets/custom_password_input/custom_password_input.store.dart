import 'package:mobx/mobx.dart';

part 'custom_password_input.store.g.dart';

class CustomPasswordInputStore = CustomPasswordInputStoreBase
    with _$CustomPasswordInputStore;

abstract class CustomPasswordInputStoreBase with Store {
  @observable
  bool obscureText = true;

  @action
  void toggleObscureText() => obscureText = !obscureText;
}
