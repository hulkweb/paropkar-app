import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:paropkar/src/custom_widgets/progress_bar.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/utills/globle_func.dart';

Future<void> deleteApi(
    {required String url,
    Map<String, String>? header,
    bool? loader,
    Function(dynamic)? onSuccess,
    Function()? onError,
    required BuildContext context,
    bool? isShowMessageToast}) async {
  try {
    //  show loading if loading
    if (loader ?? false) {
      if (kDebugMode) {
        print('show loading');
      }
      Loader.showLoaderDialog(context);
    }
    var token = await getToken();
    var headers = header ??
        {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.Request('DELETE', Uri.parse(url));
    request.headers.addAll(headers);
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 15));
    var finallRes = await getFinalResponse(response);
    print('response.statusCode');
    print(response.statusCode);
    if (isSuccess(response.statusCode)) {
      onSuccess!(finallRes) ?? () {};
    } else {}
    print(finallRes);
    if (isShowMessageToast ?? true) showMessageToast(finallRes);
    // hide loading if loading
    if (loader ?? false) {
      // ignore: use_build_context_synchronously
      Loader.hideLoaderDialog(context);
      if (kDebugMode) {
        print('hide loading');
      }
    }
  } on Exception catch (error, stackTrace) {
    print('enter in error');
    if (loader ?? false) {
      // ignore: use_build_context_synchronously
      Loader.hideLoaderDialog(context);
      if (kDebugMode) {
        print('hide loading');
      }
    }
    onError ?? () {};
    print('getting error');
    print(error);
    print('stackTrace');
    print(stackTrace);
  }
}

showMessageToast(finallRes) {
  if(finallRes['message']==null){
    return;
  }
  if (finallRes['message'].runtimeType == String) {
    Fluttertoast.showToast(msg: finallRes['message']);
  } else {
    Fluttertoast.showToast(msg: finallRes['message'][0].toString());
  }
}
