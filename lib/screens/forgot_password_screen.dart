import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/functions.dart';
import 'package:payback/providers/auth_provider.dart' as a;
import 'package:payback/screens/main_screen.dart';
import 'package:payback/screens/register.dart';
import 'package:payback/screens/smsverify.dart';
import 'package:provider/provider.dart';

import '../data/service_locator.dart';
import '../helpers/custom_widgets.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({Key? key}) : super(key: key);
 
  TextEditingController emailController = TextEditingController();

  forgotRequest(BuildContext context) {


    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Provider.of<a.AuthProvider>(context, listen: false)
          .forgotPassword({'email':emailController.text},)
          .then((value) {
        value['data'] == false
            ? showErrorMessage(context, value['message'])
            : Get.to(SMSScreen(request: {'email':emailController.text},isRegister: false,));

      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/auth_background.png'),
                  fit: BoxFit.cover)),
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/images/payback_logo.png',
                        color: kBlueColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Forgot password',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Your email',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      hintText: 'Enter your email',
                      controller: emailController,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Consumer<a.AuthProvider>(
                      builder: (context, value, child) => value.isLoading
                          ? CircularProgressIndicator()
                          : Container(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButton(
                            buttonText: 'Continue',
                            buttonColor: kPurpleColor,
                            onTap: () {
                              forgotRequest(context);
                            },
                          )),
                    ),

                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
