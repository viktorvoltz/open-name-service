import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../repo/conectivity_status.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map<dynamic, dynamic> _source = {ConnectivityResult.none: false};
  final NetworkConnectivityImpl _networkConnectivity =
      NetworkConnectivityImpl.instance;
  String string = '';

  @override
  void initState() {
    _networkConnectivity.initialise();
  _networkConnectivity.myStream.listen((source) {
    _source = source;
    print('source $_source');
    // 1.
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
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
    // 2.
    setState(() {});
    // 3.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          string,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  });
    super.initState();
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        backgroundColor: const Color(0xff6ae792),
      ),
      body: Center(
          child: Text(
        string,
        style: TextStyle(fontSize: 54),
      )),
    );
  }
}
