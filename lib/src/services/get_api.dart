import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:paropkar/src/custom_widgets/progress_bar.dart';
import 'package:paropkar/src/custom_widgets/small_widgets.dart';
import 'package:paropkar/src/services/delete_api.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/utills/globle_func.dart';

Future<void> getApi(
    {required String url,
    Map<String, String>? header,
    bool? loader,
    Function(dynamic)? onSuccess,
    Function(dynamic)? onFailed,
    Function()? onException,
    BuildContext? context,
    bool? isShowErrorMessageToast,
    bool? isShowMessageToast = false}) async {
  try {
    //  show loading if loading
    if (loader ?? false) {
      if (kDebugMode) {
        print('show loading');
      }
      Loader.showLoaderDialog(context!);
    }
    var token = await getToken();
    var headers = header ??
        { 'Authorization': 'Bearer $token','Accept': 'application/json',};
    print('___________________');
    print(headers);
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 15));
    var finallRes = await getFinalResponse(response);
    print('response is here-----');
    print(finallRes);
    print('response is here-----');
    if (isSuccess(response.statusCode)) {
      onSuccess!(finallRes) ?? () {};
    } else {
      onFailed!(finallRes) ?? () {};
    }
    if (isShowMessageToast ?? true) {
      showMessageToast(finallRes);
    }
    // hide loading if loading
    if (loader ?? false) {
      // ignore: use_build_context_synchronously
      Loader.hideLoaderDialog(context!);
      if (kDebugMode) {
        print('hide loading');
      }
    }
  } on Exception catch (error, stackTrace) {
    if (isShowErrorMessageToast ?? false) showToast(message: error.toString());

    if (loader ?? false) {
      // ignore: use_build_context_synchronously
      Loader.hideLoaderDialog(context!);
      if (kDebugMode) {
        print('hide loading');
      }
    }
    onException!() ?? () {};
    print('error');
    print(error);
    print('stackTrace');
    print(stackTrace);
  }
}
