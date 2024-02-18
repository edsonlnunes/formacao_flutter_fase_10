import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../shared/entities/release.entity.dart';
import 'services/get_all_releases.service.dart';
import 'services/get_wallet_balance.service.dart';

part 'releases.store.g.dart';

// ignore: library_private_types_in_public_api
class ReleasesStore = _ReleasesStoreBase with _$ReleasesStore;

abstract class _ReleasesStoreBase with Store {
  final GetAllReleasesService _getAllReleasesService;
  final GetWalletBalanceService _getWalletBalanceService;

  _ReleasesStoreBase(
    this._getAllReleasesService,
    this._getWalletBalanceService,
  );

  @observable
  ObservableList<Release> releasesInflow = <Release>[].asObservable();

  @observable
  ObservableList<Release> releasesOutflow = <Release>[].asObservable();

  @observable
  int actualPageIndex = 0;

  @observable
  double walletBalance = 0;

  @observable
  bool isLoading = false;

  @observable
  String? failure;

  @action
  void clearFailure() => failure = null;

  @action
  void setActualPageIndex(int index) => actualPageIndex = index;

  @action
  void addReleaseInList(Release release) {
    if (release.isInflow) {
      releasesInflow.add(release);
      releasesInflow.sort((a, b) => b.date.compareTo(a.date));
    } else {
      releasesOutflow.add(release);
      releasesOutflow.sort((a, b) => b.date.compareTo(a.date));
    }

    _getWalletBalance();
  }

  @action
  Future<void> getReleases() async {
    clearFailure();
    isLoading = true;

    try {
      final releasesTemp = await _getAllReleasesService();

      releasesInflow =
          releasesTemp.where((e) => e.isInflow == true).toList().asObservable();
      releasesOutflow = releasesTemp
          .where((e) => e.isInflow == false)
          .toList()
          .asObservable();

      releasesInflow.sort((a, b) => b.date.compareTo(a.date));
      releasesOutflow.sort((a, b) => b.date.compareTo(a.date));

      await _getWalletBalance();

      isLoading = false;
    } on DioException catch (err) {
      final message = err.response?.data['error'];

      failure = message;
      isLoading = false;
    }
  }

  @action
  Future<void> _getWalletBalance() async {
    clearFailure();
    isLoading = true;

    try {
      final walletBalanceTemp = await _getWalletBalanceService();

      walletBalance = walletBalanceTemp;
      isLoading = false;
    } on DioException catch (err) {
      final message = err.response?.data['error'];

      failure = message;
      isLoading = false;
    }
  }

  List<Release> allReleases() {
    final releases = [...releasesInflow, ...releasesOutflow].asObservable();

    releases.sort((a, b) => b.date.compareTo(a.date));

    return releases;
  }
}
