import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import 'dart:typed_data';

import '../exceptions/rpc_response.dart';

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  static final WalletConnectEthereumCredentials _ethCredInstance =
      WalletConnectEthereumCredentials._internal();

  EthereumWalletConnectProvider? provider;

  factory WalletConnectEthereumCredentials(
      {EthereumWalletConnectProvider? provider}) {
    _ethCredInstance.provider = provider;
    return _ethCredInstance;
  }

  static WalletConnectEthereumCredentials get ethCredInstance =>
      _ethCredInstance;

  WalletConnectEthereumCredentials._internal();

  @override
  Future<EthereumAddress> extractAddress() {
    // TODO: implement extractAddress
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    if (provider == null) {
      RPCResponse<String>(null, error: "Wallet not Connected");
      return 'wallet not connected';
    }else {
    final hash = await provider!.sendTransaction(
      from: transaction.from!.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );
    print(hash);
    return hash;
    }
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }
}
