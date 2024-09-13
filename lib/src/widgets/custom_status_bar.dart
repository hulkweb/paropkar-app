import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarCustom extends StatelessWidget {
  const StatusBarCustom(
      {super.key,
      required this.child,
      required this.statusBarBrightnessLight,
      required this.statusBarColor,
      this.isSafeArea});
  final Widget child;
  final bool  statusBarBrightnessLight;
  final Color statusBarColor;
  final bool? isSafeArea;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor:statusBarColor,
          statusBarIconBrightness: statusBarBrightnessLight?Brightness.light:Brightness.dark,
        ),
        child: isSafeArea ?? true ? SafeArea(child: child) : child);
  }
}
