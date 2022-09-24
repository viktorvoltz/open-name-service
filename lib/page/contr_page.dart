import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webthreeauth/globals/custom_button.dart';
import 'package:webthreeauth/service_locator.dart';

import '../repo/contract.dart';
import '../repo/wallet_connect_service.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({Key? key}) : super(key: key);

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  final TextEditingController _nameController = TextEditingController();

  String account = '';

  @override
  void dispose() {
    locator.get<DomainContract>().dispose();
    _nameController.dispose();
    super.dispose();
  }

  String? get _errorText {
    final text = _nameController.value.text;

    if (text.isEmpty) {
      return 'field is empty';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final wcs = Provider.of<WalletConnectService>(context);
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(wcs.account),
              const SizedBox(height: 20),
              CustomButton(
                  color: Colors.green,
                  text: wcs.isConnected ? "connected" : "Connect Wallet",
                  onPressed: wcs.isConnected
                      ? null
                      : () async {
                          //await locator.get<WalletConnectService>().connect();
                          await wcs.connect();
                          //account = locator.get<WalletConnectService>().getAccount();
                          wcs.getAccount();
                        }),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        maxLength: 14,
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Register a domain 🚀',
                          errorText: _errorText,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    //width: 100,
                    child: CustomButton(
                        color: Colors.green,
                        text: "register",
                        onPressed: () async {
                          await locator
                              .get<DomainContract>()
                              .registerDomain(_nameController.text);
                        }),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
