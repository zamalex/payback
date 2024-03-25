import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/phonenumber.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_widgets.dart';
import '../helpers/functions.dart';
import '../providers/auth_provider.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

   register(BuildContext context)async{
     if(_formKey.currentState!.validate()) {
       _formKey.currentState!.save();

       Map<String, String> request = {
         'name': nameController.text,
         'first_name': nameController.text,
         'last_name': nameController.text,
         'email': emailController.text,
         'password': passwordController.text,
         'password_confirmation': passwordController.text,
       };

       bool isExist = await Provider.of<AuthProvider>(context,listen: false).checkExistUser(emailController.text);

       if(isExist){
         Get.snackbar('Alert', 'Email already exists',backgroundColor: Colors.red,colorText: Colors.white);
       }else{
         Get.to(CheckPhoneNumberScreen(request: request,));

       }
       return;
     }

   }

   final _formKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Form(
        key: _formKey,
        child: Container(
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
                        Text('Full name',style: TextStyle(),),
                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomTextField(isFullName:true,hintText: 'Enter your name',controller: nameController,),
                    SizedBox(height: 15,),

                    Row(
                      children: [
                        Text('Your email',style: TextStyle(),),
                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomTextField(hintText: 'Enter your email',controller: emailController,                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Text('Your password',style: TextStyle(),),
                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomTextField(hintText: 'upper, lower, numbers, special chars',isPassword:true,obscureText: true,controller: passwordController,),
                    SizedBox(height: 20,),
                    Consumer<AuthProvider>(
                      builder:(context, value, child) => value.isLoading?CircularProgressIndicator(): Container(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButton(buttonText: 'Create account', buttonColor: kPurpleColor,onTap: (){
                            register(context);
                          },)),
                    ),
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
                    SizedBox(height: 30,),
                    Text('Or sign in with',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                    ,SizedBox(height: 5,),
                    Row(
                      children: [
                        Expanded(child: CustomIconButton(buttonText: 'Apple', iconData: 'assets/images/apple.png')),
                        SizedBox(width: 15,),
                        Expanded(child: CustomIconButton(buttonText: 'Google', iconData: 'assets/images/google.png')),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Text('Continue as a Guest',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),

                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}

