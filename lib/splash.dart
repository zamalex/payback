import 'package:flutter/material.dart';
import 'package:payback/onboarding.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => OnBoardingScreen(),)));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(child: Image.asset('assets/images/payback_logo.png')),
    );
  }
}
