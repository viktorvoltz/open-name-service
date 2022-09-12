import 'package:flutter/material.dart';
import 'package:webthreeauth/service_locator.dart';

import '../repo/contract.dart';
import '../repo/wallet_connect_service.dart';
import '../repo/wallet_connect_service.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({ Key? key }) : super(key: key);

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {


  @override
  void initState() {
    DomainContract domainContract = DomainContract();
    //domainContract.registerDomain("nonso vic");
    locator.get<WalletConnectService>().connect();
    super.initState();
  }

  @override
  void dispose() {
    DomainContract().dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}