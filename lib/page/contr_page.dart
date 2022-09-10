import 'package:flutter/material.dart';

import '../repo/contract.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({ Key? key }) : super(key: key);

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {

  

  @override
  void initState() {
    DomainContract domainContract = DomainContract();
    domainContract.registerDomain("nonso vic");
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