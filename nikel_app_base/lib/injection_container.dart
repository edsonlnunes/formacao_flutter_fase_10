import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/authentication/services/login.service.dart';
import 'features/authentication/services/register.service.dart';
import 'features/releases/services/add_release.service.dart';
import 'features/releases/services/get_all_releases.service.dart';
import 'features/releases/services/get_wallet_balance.service.dart';
import 'shared/views/theme.store.dart';
import 'utils/app.constants.dart';

final sl = GetIt.I;

slLibs() {
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: AppConstants.baseUrl)),
  );
}

void slAuthentication() {
  sl.registerLazySingleton<LoginService>(
    () => LoginService(sl()),
  );

  sl.registerLazySingleton<RegisterService>(
    () => RegisterService(sl()),
  );
}

void slReleases() {
  sl.registerLazySingleton<AddReleaseService>(
    () => AddReleaseService(sl()),
  );

  sl.registerLazySingleton<GetAllReleasesService>(
    () => GetAllReleasesService(sl()),
  );

  sl.registerLazySingleton<GetWalletBalanceService>(
    () => GetWalletBalanceService(sl()),
  );
}

void slShared() {
  sl.registerLazySingleton<ThemeStore>(() => ThemeStore());
}

void init() {
  slLibs();
  slAuthentication();
  slReleases();
  slShared();
}
