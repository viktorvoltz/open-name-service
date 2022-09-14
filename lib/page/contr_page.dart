import 'package:flutter/material.dart';
import 'package:webthreeauth/globals/custom_button.dart';
import 'package:webthreeauth/service_locator.dart';

import '../repo/contract.dart';
import '../repo/wallet_connect_service.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({ Key? key }) : super(key: key);

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {

  late DomainContract domainContract;

  @override
  void initState() {
    domainContract = DomainContract();
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
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                color: Colors.green,
                text: "Connect Wallet",
                onPressed: () async {
                  await locator.get<WalletConnectService>().connect();
              }),
              const SizedBox(height: 30,),
              CustomButton(
                color: Colors.green,
                text: "register domain name",
                onPressed: () async{
                  await domainContract.registerDomain("victor-XX345");
              })
            ]
          ),
      ),
    );
  }
}