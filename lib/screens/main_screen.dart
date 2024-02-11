import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/cart_screen.dart';
import 'package:payback/screens/commitments_screen.dart';
import 'package:payback/screens/controls_Screen.dart';
import 'package:payback/screens/home_screen.dart';
import 'package:payback/screens/map_screen.dart';
import 'package:payback/screens/shop_online_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List screens=[

  ];
  @override
  void initState() {
    // TODO: implement initState
    screens.addAll([ HomeScreen(shopAll: (){
      setState(() {
        _currentIndex=1;
      });
    },),
      ShopOnlineScreen(),
      MapSample(),
      ControlsScreen(),
      CartScreen(),]);
  }

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
              icon: Image.asset('assets/images/home_navigation.png',color: _currentIndex==0?kBlueColor:kBlueLightColor,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/online_shop_navigation.png',color: _currentIndex==1?kBlueColor:kBlueLightColor),
              label: 'Shopping inline',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/local_stores_navigation.png',color: _currentIndex==2?kBlueColor:kBlueLightColor),
              label: 'In-stores',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/controls_navigation.png',color: _currentIndex==3?kBlueColor:kBlueLightColor),
              label: 'Controls',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/cart_navigation.png',color: _currentIndex==4?kBlueColor:kBlueLightColor),
              label: 'My cart',
            ),
          ],
        ),
      ),
    );
  }
}