import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:paropkar/src/custom_widgets/progress_bar.dart';
import 'package:paropkar/src/custom_widgets/small_widgets.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/utills/globle_func.dart';

Future<void> postApi(
    {required Map<String, String> body,
    required String url,
    Map<String, String>? header,
    bool? loader,
    Function(dynamic)? onSuccess,
    Function(dynamic)? onFailed,
    Function()? onException,
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
    var request = http.MultipartRequest('POST', Uri.parse(url));
    print('here is the body');
    print(body);
    print(url);
    request.fields.addAll(body);
    request.headers.addAll(headers);
    print('++++++body and url++++++');
    print(request.url);
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 15));
    print('getting response');
    print(response);
    var finallRes = await getFinalResponse(response);
    print('++++final response++++');
    print(finallRes);
    if (isSuccess(response.statusCode)) {
      onSuccess!(finallRes) ??
          () async {
            finallRes = await getFinalResponse(response);
          };
    } else {
      onFailed!(finallRes) ?? () {};
    }
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
    print('getting error');
    print(error);
    print('stackTrace');
    print(stackTrace);
    print('enter in error');
    if (loader ?? false) {
      // ignore: use_build_context_synchronously
      Loader.hideLoaderDialog(context);
      if (kDebugMode) {
        print('hide loading');
      }
    }
    onException!();
  }
}

// Future<void> postApi(
//     {required Map<String, dynamic> body,
//     required String url,
//     Map<String, String>? header,
//     bool? loader,
//     Function(dynamic)? onSuccess,
//     Function(dynamic)? onFailed,
//     Function()? onException,
//     required BuildContext context,
//     bool? isShowMessageToast}) async {
//   try {
//     //  show loading if loading
//     if (loader ?? false) {
//       if (kDebugMode) {
//         print('show loading');
//       }
//       Loader.showLoaderDialog(context);
//     }
//     var token = await getToken();
//     var headers = header ??
//         {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
//     var request = http.Request('POST', Uri.parse(url));
//     print('here is the body');
//     print(body);
//     print(url);
//     request.body = json.encode(body);
//     request.headers.addAll(headers);
//     print('++++++body and url++++++');
//     print(request.url);
//     print(request.body);
//     http.StreamedResponse response =
//         await request.send().timeout(const Duration(seconds: 15));
//         print('getting response');
//         print(response);
//     var finallRes = await getFinalResponse(response);
//     if (isSuccess(response.statusCode)) {
//       onSuccess!(finallRes) ?? () {};
//     } else {
//       onFailed!(finallRes) ?? () {};
//     }
//     if (isShowMessageToast ?? true) showMessageToast(finallRes);
//     // hide loading if loading
//     if (loader ?? false) {
//       // ignore: use_build_context_synchronously
//       Loader.hideLoaderDialog(context);
//       if (kDebugMode) {
//         print('hide loading');
//       }
//     }
//   } on Exception catch (error, stackTrace) {
//     print('getting error');
//     print(error);
//     print('stackTrace');
//     print(stackTrace);
//     print('enter in error');
//     if (loader ?? false) {
//       // ignore: use_build_context_synchronously
//       Loader.hideLoaderDialog(context);
//       if (kDebugMode) {
//         print('hide loading');
//       }
//     }
//     onException!();
//   }
// }

showMessageToast(finallRes) {
  print(finallRes);
  if (finallRes['message'].runtimeType == String) {
    Fluttertoast.showToast(msg: finallRes['message']);
  } else {
    Fluttertoast.showToast(msg: finallRes['message'][0].toString());
  }
}

Future<void> postMultipartApi({
  required Map<String, dynamic> body,
  required Map<String, dynamic> files,
  required String url,
  Map<String, String>? header,
  bool? loader,
  Function(dynamic)? onSuccess,
  Function(dynamic)? onFailed,
  Function()? onException,
  required BuildContext context,
  bool? isShowMessageToast,
  bool? isShowErrorMessageToast,
}) async {
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

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    // request.fields.addAll(body);
    body.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    // files.forEach((key, value) async {
    //   var file = await http.MultipartFile.fromPath('$key', '$value');
    //   request.files.add(file);
    // });
    List<String> fileKeys = [];
    List<String> fileValues = [];

    for (var entry in files.entries) {
      if (entry.value.runtimeType == String) {
        fileKeys.add(entry.key);
        fileValues.add(entry.value);
      }
      if (entry.value.runtimeType == List<String>) {
        print(entry.value.runtimeType);
        for (int i = 0; i < entry.value.length; i++) {
          fileKeys.add(entry.key);
          fileValues.add(entry.value[i].toString());
        }
      }
    }
    for (int i = 0; i < fileKeys.length; i++) {
      print('-------------------------');
      print('index $i');
      print('++++++++++++');
      print(fileKeys[i]);
      print(fileValues[i]);
      var file;
      try {
        file = await http.MultipartFile.fromPath(fileKeys[i], fileValues[i]);
      } catch (e) {
        print('=====error=$i==');
        print(e);
      }

      print('file $i added');
      request.files.add(file);
      print('file $i added');
    }
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 45));
    print('final response');
    print(response);

    var finallRes = await getFinalResponse(response);
    print('finalRes');
    print(finallRes);
    if (isSuccess(response.statusCode)) {
      onSuccess!(finallRes) ?? () {};
    } else {
      onFailed!(finallRes) ?? () {};
    }
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
    if (isShowErrorMessageToast ?? false) showToast(message: error.toString());
    print('enter in error');
    if (loader ?? false) {
      // ignore: use_build_context_synchronously
      Loader.hideLoaderDialog(context);
      if (kDebugMode) {
        print('hide loading');
      }
    }

    onException!() ?? () {};
    print('getting error');
    print(error);
    print('stackTrace');
    print(stackTrace);
  }
}
