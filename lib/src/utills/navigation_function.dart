import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigation {
  static navigation(BuildContext context, Widget screenName) {
    
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => screenName), // Navigate to home screen
    );
  }
  
}
