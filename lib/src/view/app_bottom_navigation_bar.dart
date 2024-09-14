import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/view/cart/cart_screen.dart';
import 'package:paropkar/src/view/home/home_screen.dart';
import 'package:paropkar/src/view/product/category_listing_screen.dart';
import 'package:paropkar/src/view/product/product_listing_screen.dart';
import 'package:paropkar/src/view/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class BottomBarListScreen extends StatefulWidget {
  @override
  _BottomBarListScreenState createState() => _BottomBarListScreenState();
}

class _BottomBarListScreenState extends State<BottomBarListScreen> {
  // List of screens for each tab
  final List<Widget> _pages = [
    HomeScreen(),
    const CategoryListingScreen(),
    CartScreen(),
    const ProfileScreen(),
  ];

  // Bottom Navigation Bar tap handler

  // final bottomBarListController2 = BottomBarListController();
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BottomBarListController>();
    return Builder(builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          if (controller.selectedIndex == 0) {
            exit(0);
          } else {
            controller.changeIndex(0);
          }
          return false;
        },
        child: Scaffold(
          body: _pages[controller.selectedIndex], // Display selected page
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            onTap: (index) {
              controller.changeIndex(index);
              print(controller.selectedIndex);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
          ),
        ),
      );
    });
  }
}
