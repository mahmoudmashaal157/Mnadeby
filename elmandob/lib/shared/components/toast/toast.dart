import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String msg, required Color backgroundColor,required Color textColor}){
  Fluttertoast.showToast(
      msg: msg,
    gravity: ToastGravity.CENTER,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: backgroundColor,
    fontSize: 16,
    textColor: textColor
  );
}