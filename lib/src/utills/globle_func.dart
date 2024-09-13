import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showCustomToast({
  required String title,
  ToastGravity gravity = ToastGravity.BOTTOM,
  Toast toastLength = Toast.LENGTH_SHORT,
  Color backgroundColor = Colors.black54,
  Color textColor = Colors.white,
  double fontSize = 16.0,
}) {
  Fluttertoast.showToast(
    msg: title,
    toastLength: toastLength,
    gravity: gravity,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

pop(context) {
  Navigator.pop(context);
}
