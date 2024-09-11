import 'package:flutter/material.dart';
import 'package:paropkar/src/controller/splash_controller.dart';
import 'package:paropkar/src/controller/theme_controller.dart';
import 'package:paropkar/src/models/splash_model.dart';
import 'package:paropkar/src/utills/theme.dart';
import 'package:paropkar/src/view/splash_view.dart';
import 'package:provider/provider.dart';

double screenHeight = 0;
double screenWidth = 0;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    final splashModel = SplashModel(
      logoPath: 'assets/images/app_logo.png',
      subtitile: 'paropkar wholesale mart',
    );

    final splashController = SplashController(splashModel);
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: RAppTheme.lightTheme, // Apply the custom light theme
          darkTheme: RAppTheme.lightTheme, // Apply the custom dark theme
          themeMode: ThemeMode.system, // Use the current theme mode from provider
          home: SplashView(controller: splashController),
        );
      },
    );
  }
}
