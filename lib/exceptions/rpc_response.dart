import 'package:flutter/material.dart';

import '../globals/global_key.dart';

class RPCResponse<T> {
  bool succeed;
  T? data;
  String? error;

  RPCResponse(this.data, {this.error}) : succeed = error == null {
    snackbarKey.currentState?.removeCurrentSnackBar();
    late final SnackBar snackBar;
    if (!succeed) {
      snackBar = SnackBar(content: Text(error!));
      snackbarKey.currentState?.showSnackBar(snackBar);
    } else {
      snackBar = SnackBar(content: Text(data.toString()));
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}
