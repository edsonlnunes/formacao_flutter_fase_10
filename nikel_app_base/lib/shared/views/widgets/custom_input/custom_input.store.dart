import 'package:mobx/mobx.dart';

part 'custom_input.store.g.dart';

// ignore: library_private_types_in_public_api
class CustomInputStore = _CustomInputStoreBase with _$CustomInputStore;

abstract class _CustomInputStoreBase with Store {
  @observable
  bool obscurePassword = false;

  @action
  void setObscurePassword() => obscurePassword = !obscurePassword;
}