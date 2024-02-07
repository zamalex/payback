import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/functions.dart';
import 'package:payback/providers/auth_provider.dart';
import 'package:payback/screens/main_screen.dart';
import 'package:payback/screens/register.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(BuildContext context) {
    Get.to(MainScreen());
    return;

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showErrorMessage(context, 'Enter required data');
      return;
    }

    Provider.of<AuthProvider>(context, listen: false)
        .login(emailController.text, passwordController.text, '')
        .then((value) {
      showErrorMessage(context, value['message']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    'Log In',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Your password',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    hintText: 'Enter your password',
                    obscureText: true,
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<AuthProvider>(
                    builder: (context, value, child) => value.isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              buttonText: 'Log in',
                              buttonColor: kPurpleColor,
                              onTap: () {
                                login(context);
                              },
                            )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont have an account?'),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ));
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kBlueColor),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Forgot password?',
                    style: TextStyle(
                        color: kBlueColor, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Or sign in with',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomIconButton(
                              buttonText: 'Apple', iconData: Icons.apple)),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: CustomIconButton(
                              buttonText: 'Google', iconData: Icons.apple)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Continue as a Guest',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
