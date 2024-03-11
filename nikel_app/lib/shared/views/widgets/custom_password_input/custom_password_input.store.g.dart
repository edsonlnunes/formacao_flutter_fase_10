// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_password_input.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomPasswordInputStore on CustomPasswordInputStoreBase, Store {
  late final _$obscureTextAtom =
      Atom(name: 'CustomPasswordInputStoreBase.obscureText', context: context);

  @override
  bool get obscureText {
    _$obscureTextAtom.reportRead();
    return super.obscureText;
  }

  @override
  set obscureText(bool value) {
    _$obscureTextAtom.reportWrite(value, super.obscureText, () {
      super.obscureText = value;
    });
  }

  late final _$CustomPasswordInputStoreBaseActionController =
      ActionController(name: 'CustomPasswordInputStoreBase', context: context);

  @override
  void toggleObscureText() {
    final _$actionInfo = _$CustomPasswordInputStoreBaseActionController
        .startAction(name: 'CustomPasswordInputStoreBase.toggleObscureText');
    try {
      return super.toggleObscureText();
    } finally {
      _$CustomPasswordInputStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
obscureText: ${obscureText}
    ''';
  }
}
