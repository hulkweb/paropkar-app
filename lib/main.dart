import 'package:flutter/material.dart';
import 'package:paropkar/src/bloc_provider/category/category_block.dart';
import 'package:paropkar/src/bloc_provider/product/product_block.dart';
import 'package:paropkar/src/controller/address/create_address_controller.dart';
import 'package:paropkar/src/controller/address/manage_address_controller.dart';
import 'package:paropkar/src/controller/auth_controller/login_controller.dart';
import 'package:paropkar/src/controller/auth_controller/signup_controller.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/controller/category/category_controller.dart';
import 'package:paropkar/src/controller/checkout/checkout_controller.dart';
import 'package:paropkar/src/controller/favorite/favorite_controller.dart';
import 'package:paropkar/src/controller/notification/notification_controller.dart';
import 'package:paropkar/src/controller/product/product_detail_controller.dart';
import 'package:paropkar/src/controller/product/product_listing_controller.dart';
import 'package:paropkar/src/controller/profile/profile_controller.dart';
import 'package:paropkar/src/controller/splash_controller.dart';
import 'package:paropkar/src/controller/theme_controller.dart';
import 'package:paropkar/src/models/splash_model.dart';
import 'package:paropkar/src/repositories/category_repository.dart';
import 'package:paropkar/src/repositories/product_repository.dart';
import 'package:paropkar/src/utills/theme.dart';
import 'package:paropkar/src/view/address/create_address_screen_.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/auth/register_screen.dart';
import 'package:paropkar/src/view/favorite/favorite_listing_screen.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:paropkar/src/view/splach_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckoutController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => BottomBarListController()),
        ChangeNotifierProvider(create: (_) => ProductListingController()),
        ChangeNotifierProvider(create: (_) => ProductListingController()),
        ChangeNotifierProvider(create: (_) => ProductDetailController()),
        ChangeNotifierProvider(create: (_) => ManageAddressController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
        ChangeNotifierProvider(create: (_) => CreateAddressController()),
        // ChangeNotifierProvider(create: (_) => CategoryListingController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => FavoriteController()),
      ],
      child: MultiBlocProvider(
        providers: [
           BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(CategoryRepository()),
          ),
           BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(ProductRepository()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: RAppTheme.lightTheme, // Apply the custom light theme
          darkTheme: RAppTheme.lightTheme, // Apply the custom dark theme
          themeMode: ThemeMode.system, // Use the current theme mode from provider
          home: SplashView(controller: splashController),
        ),
      ),
    );
  }
}
