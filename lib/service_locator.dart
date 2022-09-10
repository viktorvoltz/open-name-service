import 'package:get_it/get_it.dart';

import 'repo/conectivity_status.dart';

final locator = GetIt.instance;

void setup(){
  locator.registerLazySingleton<NetworkConnectivityImpl>(() => NetworkConnectivityImpl.instance);
}