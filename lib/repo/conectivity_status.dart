import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';


abstract class NetworkConnectivity{
  void initialise();
  void _checkStatus(ConnectivityResult result);
  void disposeStream();
}

class NetworkConnectivityImpl extends NetworkConnectivity{
  NetworkConnectivityImpl._();
  static final _instance = NetworkConnectivityImpl._();
  static NetworkConnectivityImpl get instance => _instance;
  final _networkConnectivityImpl = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  @override
  void initialise() async {
    ConnectivityResult result = await _networkConnectivityImpl.checkConnectivity();
    _checkStatus(result);
    _networkConnectivityImpl.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  @override
  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }
  @override
  void disposeStream() => _controller.close();
}