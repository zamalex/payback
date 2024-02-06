import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/login.dart';
import 'package:payback/screens/onboarding.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1)).then((value){
        Provider.of<HomeProvider>(context,listen: false).getOnBoarding().then((value){
          if(value['data']==null){
            Get.to(LoginScreen());
          }else{
            if((value['data'] as List).isEmpty){
              Get.to(LoginScreen());
            }
            else{
              Get.to(OnBoardingScreen());
            }
          }
        });
    });

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
