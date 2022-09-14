import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color? color;

  const CustomButton(
      {Key? key, this.text, required this.onPressed, this.color})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late String os;

  @override
  void initState() {
    os = Platform.operatingSystem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (os) {
      case "android":
        return MaterialButton(
          color: widget.color,
          onPressed: widget.onPressed,
          child: Text(widget.text!),
        );
      case "ios":
        return CupertinoButton(
          color: widget.color,
          onPressed: widget.onPressed,
          child: Text(widget.text!),
        );
        default: return ElevatedButton(onPressed: widget.onPressed, child: Text(widget.text!));
    }
  }
}
