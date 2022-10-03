import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webthreeauth/globals/custom_button.dart';
import 'package:webthreeauth/service_locator.dart';

import '../repo/contract.dart';
import '../repo/wallet_connect_service.dart';
import 'collection_web_view.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({Key? key}) : super(key: key);

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _address = TextEditingController();

  dynamic? domainAddress;

  @override
  void dispose() {
    locator.get<DomainContract>().dispose();
    _nameController.dispose();
    _address.dispose();
    super.dispose();
  }

  /*String? get _errorText {
    final text = _nameController.value.text;

    if (text.isEmpty) {
      return 'field is empty';
    }

    return null;
  }*/

  @override
  Widget build(BuildContext context) {
    final wcs = Provider.of<WalletConnectService>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Register a .voltz domain for 0.1 MATIC"),
              const SizedBox(
                height: 10,
              ),
              Text(wcs.account),
              const SizedBox(height: 20),
              CustomButton(
                  color: Colors.black,
                  text: wcs.isConnected ? "connected" : "Connect Wallet",
                  onPressed: wcs.isConnected
                      ? null
                      : () async {
                          await wcs.connect();
                          wcs.getAccount();
                        }),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        maxLength: 14,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Register a domain 🚀',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: CustomButton(
                        color: Colors.black,
                        text: "register",
                        onPressed: () async {
                          await locator
                              .get<DomainContract>()
                              .registerDomain(_nameController.text);
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _address,
                        decoration: const InputDecoration(
                          hintText: 'check domain, E.g `john`',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    //width: 100,
                    child: CustomButton(
                        color: Colors.black,
                        text: "get Address",
                        onPressed: () async {
                          domainAddress = await locator
                              .get<DomainContract>()
                              .getAddress(_address.text);
                          setState(() {});
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('(.)voltz domain owner:'),
              const SizedBox(
                height: 10,
              ),
              domainAddress == null
                  ? Container()
                  : Text(domainAddress[0].toString().contains('0x0000000000')
                      ? '${_address.text}.voltz is unregistered yet'
                      : '${_address.text}.voltz is owned by\n${domainAddress[0]}'),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                color: Colors.black,
                text: "Collections",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const CollectionWebView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
