import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

import 'ethereum_credentials.dart';

class WalletConnectService extends ChangeNotifier {

  bool _isConnected = false;
  String _account = '';

  bool get isConnected => _isConnected;
  String get account => _account;

  final connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: const PeerMeta(
      name: 'Voltz Domains',
      description: 'Voltz Domain dApp',
      url: 'https://walletconnect.org',
      icons: [
        'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
      ],
    ),
  );

  late SessionStatus sessionStatus;

  WalletConnectService() {
    _registerListeners();
  }

  void _registerListeners() {
    /// on connect
    connector.on('connect', (session) async {
      sessionStatus = await connector.connect(chainId: 80001);
    });

    /// on session update
    connector.on(
      'session_update',
      (session) async => await connector.updateSession(sessionStatus),
    );

    /// on session request
    connector.on('session_request', (payload) async {
      await connector.approveSession(
          chainId: 80001, accounts: sessionStatus.accounts);

      await connector.updateSession(
          SessionStatus(chainId: 80001, accounts: sessionStatus.accounts));
    });

    /// on session disconnect
    connector.on('disconnect', (message) async {
      await connector.killSession(sessionError: message.toString());
    });
  }

  Future<void> connect() async {
    if (!connector.connected) {
      sessionStatus = await connector.createSession(
          chainId: 80001, onDisplayUri: (uri) => launchUrlString(uri));
    } else {
      connector.reconnect();
    }
    _isConnected = true;
    notifyListeners();
    walletProvider();
  }

  String getAccount(){
    _account = sessionStatus.accounts[0];
    notifyListeners();
    print(_account);
    return sessionStatus.accounts[0];
  }

  void walletProvider(){
    EthereumWalletConnectProvider provider = EthereumWalletConnectProvider(connector, chainId: 80001);
    WalletConnectEthereumCredentials(provider: provider);
  }
}