import 'package:get_it/get_it.dart';

import 'repo/conectivity_status.dart';
import 'repo/contract.dart';
import 'repo/wallet_connect_service.dart';

final locator = GetIt.instance;

void setup(){
  locator.registerLazySingleton<NetworkConnectivityImpl>(() => NetworkConnectivityImpl.instance);
  locator.registerLazySingleton<WalletConnectService>(() => WalletConnectService());
  locator.registerLazySingleton<DomainContract>(() => DomainContract());
}