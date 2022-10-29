import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'page/home_page.dart';
import 'globals/global_key.dart';
import 'page/contr_page.dart';
import 'service_locator.dart';
import 'repo/wallet_connect_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
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
      title: 'Open DNS dApp',
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
