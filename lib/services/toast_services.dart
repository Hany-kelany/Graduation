import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

showToast(
    String text,
    {bool shortToast = true,
      fromBottom = true,
      Color color =  Colors.white,
      Color? textColor}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: shortToast ? Toast.LENGTH_SHORT : Toast.LENGTH_SHORT,
      gravity: fromBottom ? ToastGravity.BOTTOM : ToastGravity.TOP,
      backgroundColor: color,
      textColor: Color(0xff032b50),
      fontSize: 16.0);

}
