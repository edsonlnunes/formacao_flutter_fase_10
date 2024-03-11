import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/utils/constants.dart';

part 'splash.store.g.dart';

class SplashStore = SplashStoreBase with _$SplashStore;

abstract class SplashStoreBase with Store {
  Future<bool> userIsAuthenticated() async {
    await Future.delayed(const Duration(seconds: 2));
    final sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("userToken");
    if (token == null) return false;
    Constants.userToken = token;
    return true;
  }
}
