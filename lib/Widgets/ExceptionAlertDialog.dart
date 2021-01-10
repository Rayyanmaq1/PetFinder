import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  void showToast(error) {
    print(error);
    Fluttertoast.showToast(
        msg: error,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
