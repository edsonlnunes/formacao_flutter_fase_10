// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on RegisterStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'RegisterStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$createAccountAsyncAction =
      AsyncAction('RegisterStoreBase.createAccount', context: context);

  @override
  Future<void> createAccount({required String email, required String pass}) {
    return _$createAccountAsyncAction
        .run(() => super.createAccount(email: email, pass: pass));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
