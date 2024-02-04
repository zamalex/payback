import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/cart_screen.dart';
import 'package:payback/screens/commitments_screen.dart';
import 'package:payback/screens/home_screen.dart';
import 'package:payback/screens/shop_online_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List screens=[
    CartScreen(),
    ShopOnlineScreen(),
    ShopOnlineScreen(),
    ShopOnlineScreen(),
    ShopOnlineScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(

        ),
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: BottomNavigationBar(
          selectedItemColor: kBlueColor,
         showUnselectedLabels: true,
         // selectedLabelStyle: TextStyle(color: kBlueColor),
          unselectedItemColor: kBlueLightColor,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded),
              label: 'Shopping inline',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin),
              label: 'In-stores',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: 'Controls',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'My cart',
            ),
          ],
        ),
      ),
    );
  }
}