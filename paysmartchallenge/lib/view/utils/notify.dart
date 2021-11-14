import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Notify {
  static void error(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red[100],
      textColor: Colors.red[900],
      gravity: ToastGravity.TOP,
      fontSize: 18,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
