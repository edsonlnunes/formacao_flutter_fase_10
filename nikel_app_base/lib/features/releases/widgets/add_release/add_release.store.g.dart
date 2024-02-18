// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_release.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddReleaseStore on _AddReleaseStoreBase, Store {
  late final _$isInflowAtom =
      Atom(name: '_AddReleaseStoreBase.isInflow', context: context);

  @override
  bool get isInflow {
    _$isInflowAtom.reportRead();
    return super.isInflow;
  }

  @override
  set isInflow(bool value) {
    _$isInflowAtom.reportWrite(value, super.isInflow, () {
      super.isInflow = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AddReleaseStoreBase.isLoading', context: context);

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

  late final _$failureAtom =
      Atom(name: '_AddReleaseStoreBase.failure', context: context);

  @override
  String? get failure {
    _$failureAtom.reportRead();
    return super.failure;
  }

  @override
  set failure(String? value) {
    _$failureAtom.reportWrite(value, super.failure, () {
      super.failure = value;
    });
  }

  late final _$addReleaseAsyncAction =
      AsyncAction('_AddReleaseStoreBase.addRelease', context: context);

  @override
  Future<Release?> addRelease(
      {required double value,
      required String description,
      required DateTime date}) {
    return _$addReleaseAsyncAction.run(() =>
        super.addRelease(value: value, description: description, date: date));
  }

  late final _$_AddReleaseStoreBaseActionController =
      ActionController(name: '_AddReleaseStoreBase', context: context);

  @override
  void setisInflow() {
    final _$actionInfo = _$_AddReleaseStoreBaseActionController.startAction(
        name: '_AddReleaseStoreBase.setisInflow');
    try {
      return super.setisInflow();
    } finally {
      _$_AddReleaseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearFailure() {
    final _$actionInfo = _$_AddReleaseStoreBaseActionController.startAction(
        name: '_AddReleaseStoreBase.clearFailure');
    try {
      return super.clearFailure();
    } finally {
      _$_AddReleaseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isInflow: ${isInflow},
isLoading: ${isLoading},
failure: ${failure}
    ''';
  }
}
