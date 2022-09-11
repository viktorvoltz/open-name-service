import 'package:flutter/material.dart';

import '../globals/global_key.dart';

abstract class GeneralException implements Exception {
  const GeneralException([this.message]);

  final String? message;

  @override
  String toString() {
    String result = 'GeneralException';
    if (message is String) return '$result: $message';
    return result;
  }
}

class RRPCError extends GeneralException{
  RRPCError(String message) :super(message){
    final SnackBar snackBar = SnackBar(content: Text(message));
    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}

class UnkwownException extends GeneralException{
  UnkwownException(String message) : super(message){
    final SnackBar snackBar = SnackBar(content: Text(message));
    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}