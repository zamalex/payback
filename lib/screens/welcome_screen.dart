import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/onboarding.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 16),

          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
          padding: EdgeInsets.all(8).copyWith(top: MediaQuery.of(context).viewPadding.top),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Payback',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(5, 46, 74, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 45),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'All-in-one app to collect and share cashback. Purchase products, get cashback and use it in any way you want',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      Image.asset('assets/images/walletpic.png',width: MediaQuery.of(context).size.width-50,height: MediaQuery.of(context).size.width-50,)
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                child: CustomButton(
                  onTap: (){
                    Get.to(OnBoardingScreen(data: Provider.of<HomeProvider>(context,listen: false).onBoarding??[]));
                  },
                  buttonText: 'Great, let’s start',
                  buttonColor: Colors.white,
                  textColor: kPurpleColor,
                ),
              )
            ],
          ),
        ),

    );
  }
}
