// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'releases.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReleasesStore on ReleasesStoreBase, Store {
  late final _$isLoadingBalanceAtom =
      Atom(name: 'ReleasesStoreBase.isLoadingBalance', context: context);

  @override
  bool get isLoadingBalance {
    _$isLoadingBalanceAtom.reportRead();
    return super.isLoadingBalance;
  }

  @override
  set isLoadingBalance(bool value) {
    _$isLoadingBalanceAtom.reportWrite(value, super.isLoadingBalance, () {
      super.isLoadingBalance = value;
    });
  }

  late final _$walletBalanceAtom =
      Atom(name: 'ReleasesStoreBase.walletBalance', context: context);

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

  late final _$loadWalletBalanceAsyncAction =
      AsyncAction('ReleasesStoreBase.loadWalletBalance', context: context);

  @override
  Future<void> loadWalletBalance() {
    return _$loadWalletBalanceAsyncAction.run(() => super.loadWalletBalance());
  }

  @override
  String toString() {
    return '''
isLoadingBalance: ${isLoadingBalance},
walletBalance: ${walletBalance}
    ''';
  }
}
