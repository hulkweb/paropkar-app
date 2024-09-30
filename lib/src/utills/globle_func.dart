import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/controller/product/product_detail_controller.dart';
import 'package:paropkar/src/custom_widgets/dialog/success_dialog.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
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
    {required String type,
    required String title,
    required String description,
    VoidCallback? ontapOk}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return DialogBox(
      //   type: 'success',
      //   title: title ?? "Awesome!",
      //   description: description ??
      //       "Your booking has been confirmed. Check your email for details.",
      // );
      return DialogBox(
        type: type,
        title: title,
        description: description,
        ontapOk: ontapOk,
      );
    },
  );
}


Future<Map<String, String>> getHeaders()async{
   var token = await getToken();
    return  { 'Authorization': 'Bearer $token','Accept': 'application/json',};
}

getFinalResponse(http.StreamedResponse response) async {
  String result = await response.stream.bytesToString();
  if (kDebugMode) {
    print('+++++status+ ++++');
    print(response.statusCode);
  }
  print('+++++result+++++');
  print(result);
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

String formatData(dynamic data) {
  if (data == null) {
    return ''; // Return empty string if data is null
  } else if (data is String) {
    return data; // Return string if data is already a string
  } else if (data is double || data is int) {
    return data.toString(); // Convert double/int to string
  } else {
    return ''; // Return empty string for any other type
  }
}

bool hasNoData( data) {
  print('-------${data.runtimeType}----${data}-------');
  return (data == null || data.isEmpty);
}

