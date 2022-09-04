import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';


abstract class NetworkConnectivity{
  void _checkStatus(ConnectivityResult result);
  void disposeStream();
}

class NetworkConnectivityImpl extends NetworkConnectivity{
  NetworkConnectivityImpl._();
  static final _instance = NetworkConnectivityImpl._();
  static NetworkConnectivityImpl get instance => _instance;
  final _NetworkConnectivityImpl = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _NetworkConnectivityImpl.checkConnectivity();
    _checkStatus(result);
    _NetworkConnectivityImpl.onConnectivityChanged.listen((result) {
      print(result);
      _checkStatus(result);
    });
  }

  @override
  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('https://google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }
  @override
  void disposeStream() => _controller.close();
}