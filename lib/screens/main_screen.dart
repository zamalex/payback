import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/cart_screen.dart';
import 'package:payback/screens/commitments_screen.dart';
import 'package:payback/screens/controls_Screen.dart';
import 'package:payback/screens/home_screen.dart';
import 'package:payback/screens/map_screen.dart';
import 'package:payback/screens/shop_online_screen.dart';


class MainScreen extends StatefulWidget {

  MainScreen({this.index});
  int? index;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List screens=[

  ];
  @override
  void initState() {

    _currentIndex = widget.index??0;
    // TODO: implement initState
    screens.addAll([ HomeScreen(shopAll: (){
      setState(() {
        _currentIndex=1;
      });
    },),
      ShopOnlineScreen(),
      MapSample(),
      ControlsScreen(),
      CartScreen(selectNav: (){
        setState(() {
          _currentIndex=0;
        });
      },),]);
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
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/home_navigation.png',color: _currentIndex==0?kBlueColor:Colors.grey,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/online_shop_navigation.png',color: _currentIndex==1?kBlueColor:Colors.grey),
              label: 'Shopping online',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/local_stores_navigation.png',color: _currentIndex==2?kBlueColor:Colors.grey),
              label: 'In-stores',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/controls_navigation.png',color: _currentIndex==3?kBlueColor:Colors.grey),
              label: 'Controls',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/cart_navigation.png',color: _currentIndex==4?kBlueColor:Colors.grey),
              label: 'My cart',
            ),
          ],
        ),
      ),
    );
  }
}