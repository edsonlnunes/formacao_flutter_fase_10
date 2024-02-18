// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'releases.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReleasesStore on _ReleasesStoreBase, Store {
  late final _$releasesInflowAtom =
      Atom(name: '_ReleasesStoreBase.releasesInflow', context: context);

  @override
  ObservableList<Release> get releasesInflow {
    _$releasesInflowAtom.reportRead();
    return super.releasesInflow;
  }

  @override
  set releasesInflow(ObservableList<Release> value) {
    _$releasesInflowAtom.reportWrite(value, super.releasesInflow, () {
      super.releasesInflow = value;
    });
  }

  late final _$releasesOutflowAtom =
      Atom(name: '_ReleasesStoreBase.releasesOutflow', context: context);

  @override
  ObservableList<Release> get releasesOutflow {
    _$releasesOutflowAtom.reportRead();
    return super.releasesOutflow;
  }

  @override
  set releasesOutflow(ObservableList<Release> value) {
    _$releasesOutflowAtom.reportWrite(value, super.releasesOutflow, () {
      super.releasesOutflow = value;
    });
  }

  late final _$actualPageIndexAtom =
      Atom(name: '_ReleasesStoreBase.actualPageIndex', context: context);

  @override
  int get actualPageIndex {
    _$actualPageIndexAtom.reportRead();
    return super.actualPageIndex;
  }

  @override
  set actualPageIndex(int value) {
    _$actualPageIndexAtom.reportWrite(value, super.actualPageIndex, () {
      super.actualPageIndex = value;
    });
  }

  late final _$walletBalanceAtom =
      Atom(name: '_ReleasesStoreBase.walletBalance', context: context);

  @override
  double get walletBalance {
    _$walletBalanceAtom.reportRead();
    return super.walletBalance;
  }

  @override
  set walletBalance(double value) {
    _$walletBalanceAtom.reportWrite(value, super.walletBalance, () {
      super.walletBalance = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ReleasesStoreBase.isLoading', context: context);

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
      Atom(name: '_ReleasesStoreBase.failure', context: context);

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

  late final _$getReleasesAsyncAction =
      AsyncAction('_ReleasesStoreBase.getReleases', context: context);

  @override
  Future<void> getReleases() {
    return _$getReleasesAsyncAction.run(() => super.getReleases());
  }

  late final _$_getWalletBalanceAsyncAction =
      AsyncAction('_ReleasesStoreBase._getWalletBalance', context: context);

  @override
  Future<void> _getWalletBalance() {
    return _$_getWalletBalanceAsyncAction.run(() => super._getWalletBalance());
  }

  late final _$_ReleasesStoreBaseActionController =
      ActionController(name: '_ReleasesStoreBase', context: context);

  @override
  void clearFailure() {
    final _$actionInfo = _$_ReleasesStoreBaseActionController.startAction(
        name: '_ReleasesStoreBase.clearFailure');
    try {
      return super.clearFailure();
    } finally {
      _$_ReleasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setActualPageIndex(int index) {
    final _$actionInfo = _$_ReleasesStoreBaseActionController.startAction(
        name: '_ReleasesStoreBase.setActualPageIndex');
    try {
      return super.setActualPageIndex(index);
    } finally {
      _$_ReleasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addReleaseInList(Release release) {
    final _$actionInfo = _$_ReleasesStoreBaseActionController.startAction(
        name: '_ReleasesStoreBase.addReleaseInList');
    try {
      return super.addReleaseInList(release);
    } finally {
      _$_ReleasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
releasesInflow: ${releasesInflow},
releasesOutflow: ${releasesOutflow},
actualPageIndex: ${actualPageIndex},
walletBalance: ${walletBalance},
isLoading: ${isLoading},
failure: ${failure}
    ''';
  }
}
