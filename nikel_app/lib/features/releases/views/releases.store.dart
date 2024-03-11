import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/error/custom_exception.dart';
import '../services/releases.service.dart';

part 'releases.store.g.dart';

class ReleasesStore = ReleasesStoreBase with _$ReleasesStore;

abstract class ReleasesStoreBase with Store {
  final _service = ReleasesService(GetIt.I.get());

  @observable
  bool isLoadingBalance = false;

  String? error;

  @observable
  double walletBalance = 0;

  @action
  Future<void> loadWalletBalance() async {
    try {
      error = null;
      isLoadingBalance = true;

      final result = await _service.getWalletBalance();

      walletBalance = result;
    } on CustomException catch (e) {
      error = e.message;
    } finally {
      isLoadingBalance = false;
    }
  }
}
