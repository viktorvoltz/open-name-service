import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import '../constants/node_api.dart';
import '../exceptions/rpc_response.dart';
import '../constants/constants.dart';
import 'ethereum_credentials.dart';

class DomainContract {
  static const String _rpcUrl =
      'https://polygon-mumbai.g.alchemy.com/v2/$rpc_api';
  static const String _wsUrl =
      'wss://polygon-mumbai.g.alchemy.com/v2/$wss_api';

  late Web3Client _client;

  EthereumAddress? _contractAddress;

  DomainContract() {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
  }

  Future<DeployedContract> deployedContract() async {
    String contractAbi = await rootBundle.loadString("assets/Domains.json");
    final jsonCode = jsonDecode(contractAbi);
    final abiCode = jsonEncode(jsonCode["abi"]);

    /// deployed contract address
    _contractAddress =
        EthereumAddress.fromHex("0x8c328B7f4856438FbeAa59f9e28F6fDd98B4588d");

    final contract = DeployedContract(
        ContractAbi.fromJson(abiCode, "Domains"), _contractAddress!);

    return contract;
  }

  /// query contract for information like [balance] and [record].
  Future<List<dynamic>?> _queryContract(
      String functionName, List<dynamic> args) async {
    final contract = await deployedContract();
    final contractFunction = contract.function(functionName);
    try{
    final result = await _client.call(
        contract: contract, function: contractFunction, params: args);
        return result;
    }catch(e){
      RPCResponse<List<dynamic>>(null, error: e.toString());
    }
    return null;
  }

  Transaction _callTransac({DeployedContract? contract, 
  EthereumAddress? from, ContractFunction? function, List<dynamic>? 
  parameters, EtherAmount? value}){
    final tx = Transaction.callContract(contract: contract!, function: function!, parameters: parameters!, value: value, from: from);
    WalletConnectEthereumCredentials.ethCredInstance.sendTransaction(tx);
    return tx;
  }

  Future<String?> _sendTransaction(
      String functionName, bool isValued, List<dynamic> args) async {
    EthPrivateKey credential = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await deployedContract();

    final contractFunction = contract.function(functionName);
    try {
      final result = await _client.sendTransaction(
        credential,
        _callTransac(
          contract: contract,
          from: await credential.extractAddress(),
          function: contractFunction,
          parameters: args,
          value: isValued
              ? EtherAmount.fromUnitAndValue(
                  EtherUnit.wei, '100000000000000000')
              : null,
        ),
        chainId: 80001,
      );
      /*TransactionInformation txHash =
          await _client.getTransactionByHash(result);
      print(txHash.toString());
      TransactionReceipt? txReciept =
          await _client.getTransactionReceipt(result);
      print(txReciept.toString());*/
      return result;
    } catch (e) {
      RPCResponse<String>(null, error: e.toString());
      return null;
    }
  }

  Future registerDomain(String nameToRegister) async {
    await _sendTransaction("register", true, [nameToRegister]);
  }

  /// EOA address associated with name
  Future getAddress(String name) async {
    final address = await _queryContract("getAddress", [name]);
    return address;
  }

  Future setRecord(String name, String record) async {
    final xrecord = await _sendTransaction("setRecord", false, [name, record]);
    return xrecord;
  }

  Future getRecord(String records) async {
    final record = await _queryContract("getRecord", [records]);
    return record;
  }

  Future<void> dispose() async {
    await _client.dispose();
  }
}
