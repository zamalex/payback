import 'package:flutter/material.dart';
import 'package:payback/colors.dart';

import 'custom_widgets.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/auth_background.png'),fit: BoxFit.cover)),
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                SizedBox(height: 20,),
                Text('Forgot password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                SizedBox(height: 10,),
                Text('Please, enter and email associated with your account',textAlign: TextAlign.center),

                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('Email',style: TextStyle(),),
                  ],
                ),
                SizedBox(height: 5,),
                CustomTextField(hintText: 'Enter your Email'),

                SizedBox(height: 20,),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(buttonText: 'Send', buttonColor: kPurpleColor)),
                SizedBox(height: 20,),
              
              ]
          ),
        ),
      ),
    );
  }
}

