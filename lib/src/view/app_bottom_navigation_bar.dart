import 'package:flutter/material.dart';
import 'package:paropkar/src/view/cart/cart_screen.dart';
import 'package:paropkar/src/view/home/home_screen.dart';
import 'package:paropkar/src/view/product/category_product_listing_screen.dart';
import 'package:paropkar/src/view/profile/profile_screen.dart';

class BottomBarListScreen extends StatefulWidget {
  @override
  _BottomBarListScreenState createState() => _BottomBarListScreenState();
}

class _BottomBarListScreenState extends State<BottomBarListScreen> {
  int _selectedIndex = 0;

  // List of screens for each tab
  final List<Widget> _pages = [
    HomeScreen(),
    const CategoryProductScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  // Bottom Navigation Bar tap handler
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
    );
  }
}



