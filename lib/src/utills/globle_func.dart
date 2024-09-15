import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/custom_widgets/dialog/success_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
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

showDialogBox(BuildContext context,
    {String? type, String? title, String? description}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return DialogBox(
      //   type: 'success',
      //   title: title ?? "Awesome!",
      //   description: description ??
      //       "Your booking has been confirmed. Check your email for details.",
      // );
      return DialogBox(
        type: 'error',
        title: title ?? "Sorry!",
        description: description ??
            "Your booking has not been confirmed. An Error Occured ",
      );
    },
  );
}



getFinalResponse(http.StreamedResponse response) async {
  String result = await response.stream.bytesToString();
  if (kDebugMode) {
    print('status');
    print(response.statusCode);
  }
  return jsonDecode(result);
}

bool getDataEmptyOrNot(var finalRes) {
  if (finalRes['data'] == null || finalRes['data'].isEmpty) {
    return true;
  }
  return false;
}
// bool successStatus = (201 || 201);
isSuccess(int statusCode) {
  if (statusCode == 201 || statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
