// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_input.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomInputStore on _CustomInputStoreBase, Store {
  late final _$obscurePasswordAtom =
      Atom(name: '_CustomInputStoreBase.obscurePassword', context: context);

  @override
  bool get obscurePassword {
    _$obscurePasswordAtom.reportRead();
    return super.obscurePassword;
  }

  @override
  set obscurePassword(bool value) {
    _$obscurePasswordAtom.reportWrite(value, super.obscurePassword, () {
      super.obscurePassword = value;
    });
  }

  late final _$_CustomInputStoreBaseActionController =
      ActionController(name: '_CustomInputStoreBase', context: context);

  @override
  void setObscurePassword() {
    final _$actionInfo = _$_CustomInputStoreBaseActionController.startAction(
        name: '_CustomInputStoreBase.setObscurePassword');
    try {
      return super.setObscurePassword();
    } finally {
      _$_CustomInputStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
obscurePassword: ${obscurePassword}
    ''';
  }
}
