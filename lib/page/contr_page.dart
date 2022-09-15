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

  String account = 'xxxx';

  @override
  void dispose() {
    locator.get<DomainContract>().dispose();
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
              Text(account),
              const SizedBox(height: 20),
              CustomButton(
                color: Colors.green,
                text: "Connect Wallet",
                onPressed: () async {
                  await locator.get<WalletConnectService>().connect();
                  account = locator.get<WalletConnectService>().getAccount();
                  setState(() {});
              }),
              const SizedBox(height: 30,),
              CustomButton(
                color: Colors.green,
                text: "register domain name",
                onPressed: () async{
                  await locator.get<DomainContract>().registerDomain("victor-XX345");
              })
            ]
          ),
      ),
    );
  }
}