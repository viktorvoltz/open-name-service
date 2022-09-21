import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:webthreeauth/page/contr_page.dart';
import 'package:webthreeauth/repo/wallet_connect_service.dart';
import 'package:webthreeauth/service_locator.dart';
import 'package:provider/provider.dart';

import 'page/home_page.dart';
import 'globals/global_key.dart';

void main() {
  setup();
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[ChangeNotifierProvider(create: (_) => WalletConnectService())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
