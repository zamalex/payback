import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';

import '../helpers/custom_widgets.dart';

class CheckPhoneNumberScreen extends StatelessWidget {
  const CheckPhoneNumberScreen({Key? key}) : super(key: key);

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
                  Text('Confirm phone number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  SizedBox(height: 10,),
                  Text('To get all the benefits from Payback, please, authenticate your phone number via SMS code',textAlign: TextAlign.center),

                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text('Phone number',style: TextStyle(),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  CustomTextField(hintText: 'Enter your phone number'),

                  SizedBox(height: 20,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(buttonText: 'Send', buttonColor: kPurpleColor)),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      SizedBox(width: 5,),
                      Text('Sign in',style: TextStyle(fontWeight: FontWeight.bold,color: kBlueColor),),
                    ],
                  ),

                  Expanded(child: Text('Continue as a Guest',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),

                ]
            ),
          ),
      ),
    );
  }
}

