import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/model/auth_response.dart';
import 'package:payback/model/onboarding_response.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/invitation_screen.dart';
import 'package:payback/screens/login.dart';
import 'package:payback/screens/main_screen.dart';
import 'package:payback/screens/onboarding.dart';
import 'package:payback/screens/payment_screen.dart';
import 'package:payback/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import '../data/service_locator.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {



  String computeHash(String id, String amount, String currency, String description, String password) {
    // Concatenate the inputs
    String concatenated = '$id$amount$currency$description$password';

    // Convert to uppercase
    String uppercased = concatenated.toUpperCase();
    print('upper:$uppercased');

    // Compute the MD5 hash
    var md5Hash = md5.convert(utf8.encode(uppercased)).toString();
    print('md5:$md5Hash');

    // Compute the SHA-1 hash of the MD5 result
    var sha1Hash = sha1.convert(utf8.encode(md5Hash)).toString();
    print('sha1:$sha1Hash');

    return sha1Hash;
  }

  mocPayment(){
    String id = '10';
    String amount = '1';
    String currency = 'SAR';
    String description = 'haha';
    String password = '301d32068ef211f64c6af7287558e77f';

    // Compute the hash
    String result = computeHash(id, amount, currency, description, password);


  //  Get.to(PaymentScreen(url: 'https://pay.edfapay.com/merchant/checkout/10/f3830a26-62e5-4723-8ac6-5549f816be5b'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1)).then((value) {
      Provider.of<HomeProvider>(context, listen: false)
          .getOnBoarding()
          .then((value) {
         //   mocPayment();
        //    return;

        if (sl.isRegistered<AuthResponse>()) {
          sl<PreferenceUtils>().readInvitation().then((value) {
            value == null ? Get.to(MainScreen()) : Get.to(InvitationScreen());
          });

          return;
        }

        sl<PreferenceUtils>().readIProduct().then((value) {
          if(value!=null){
            Get.to(MainScreen());
          }
        });

        if (value['data'] == null) {
          Get.to(LoginScreen());
        } else {
          if ((value['data'] as List).isEmpty) {
            Get.to(LoginScreen());
          } else {
            Get.to(WelcomeScreen());
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
