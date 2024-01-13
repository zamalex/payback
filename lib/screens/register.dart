import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';

import '../helpers/custom_widgets.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/auth_background.png'),fit: BoxFit.cover)),
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Padding(padding: EdgeInsets.all(10),child: Image.asset('assets/images/payback_logo.png',color: kBlueColor,),),
                  SizedBox(height: 20,),
                  Text('Create account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text('First name',style: TextStyle(),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  CustomTextField(hintText: 'Enter your name'),
                  SizedBox(height: 15,),

                  Row(
                    children: [
                      Text('Your email',style: TextStyle(),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  CustomTextField(hintText: 'Enter your email'),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text('Your password',style: TextStyle(),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  CustomTextField(hintText: 'Enter your password',obscureText: true,),
                  SizedBox(height: 20,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(buttonText: 'Create account', buttonColor: kPurpleColor)),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      SizedBox(width: 5,),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
                        },
                          child: Text('Sign in',style: TextStyle(fontWeight: FontWeight.bold,color: kBlueColor),)),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Text('Or sign in with',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                  ,SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(child: CustomIconButton(buttonText: 'Apple', iconData: Icons.apple)),
                      SizedBox(width: 15,),
                      Expanded(child: CustomIconButton(buttonText: 'Google', iconData: Icons.apple)),

                    ],
                  ),
                  SizedBox(height: 20,),
                  Text('Continue as a Guest',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),

                ]
            ),
          ),
        ),
      ),
    );
  }
}

