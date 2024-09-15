import 'package:flutter/material.dart';

class Loader {
  static void showLoaderDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLoader(),
          ],
        );
      },
    );
  }

  static void hideLoaderDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Center(
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Adjust the shadow offset as needed
                ),
              ],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
