import 'package:flutter/material.dart';
import 'package:webthreeauth/globals/connectivity_listener.dart';
import 'package:webthreeauth/service_locator.dart';

import '../repo/conectivity_status.dart';
import 'contr_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
  connectivityListener();
    super.initState();
  }

  @override
  void dispose() {
    locator.get<NetworkConnectivityImpl>().disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const ContractPage();
  }
}
