import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../repo/conectivity_status.dart';
import '../service_locator.dart';
import 'global_key.dart';

Map<ConnectivityResult, dynamic> _source = {ConnectivityResult.none: false};
NetworkConnectivityImpl listener = locator.get<NetworkConnectivityImpl>();
String string = '';

void connectivityListener(){
  late bool isOnline;
  locator.get<NetworkConnectivityImpl>().initialise();
  listener.myStream.listen((event) {
    isOnline = false;
    _source = event;
    
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        isOnline = _source.values.toList()[0] ? true : false;
        string =
            _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
        break;
      case ConnectivityResult.wifi:
        string =
            _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
        break;
      case ConnectivityResult.none:
      default:
        string = 'Offline';
    }

    final SnackBar snackBar = SnackBar(content: Text(string), backgroundColor: isOnline ? Colors.green : Colors.red);
    snackbarKey.currentState?.showSnackBar(snackBar);
  });

}