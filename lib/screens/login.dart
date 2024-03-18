import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/functions.dart';
import 'package:payback/providers/auth_provider.dart' as a;
import 'package:payback/screens/forgot_password_screen.dart';
import 'package:payback/screens/main_screen.dart';
import 'package:payback/screens/register.dart';
import 'package:provider/provider.dart';

import '../data/service_locator.dart';
import '../helpers/custom_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<User?> _handleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      if(user!=null)
      print('user ${user?.email}');
     // print('token ${googleSignInAuthentication.accessToken}');
     // print('id token ${googleSignInAuthentication.idToken}');

      Provider.of<a.AuthProvider>(context, listen: false)
          .socialLogin({'provider':'google','name':user?.displayName??'','email':user?.email??''})
          .then((value){
        value['data'] == null
            ?Get.snackbar('Alert', value['message'],backgroundColor: Colors.red,colorText: Colors.white): Get.to(MainScreen());
        if (value['data'] != null) {
          sl<PreferenceUtils>().saveUser(value['data']);
        }
      });
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(BuildContext context) {
    /*Get.to(MainScreen());
    return;*/

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();


      Provider.of<a.AuthProvider>(context, listen: false)
          .login(emailController.text, passwordController.text, '')
          .then((value) {
        value['data'] == null
            ?Get.snackbar('Alert', value['message'],backgroundColor: Colors.red,colorText: Colors.white): Get.to(MainScreen());
        if (value['data'] != null) {
          sl<PreferenceUtils>().saveUser(value['data']);
        }
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
                      'Log In',
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
                      type: TextInputType.emailAddress,
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
                      isPassword: true,

                      controller: passwordController,
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
                                  fontWeight: FontWeight.bold,
                                  color: kBlueColor),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){Get.to(ForgotScreen());},
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            color: kBlueColor, fontWeight: FontWeight.bold),
                      ),
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
                                buttonText: 'Apple', iconData: 'assets/images/apple.png')),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: CustomIconButton(
                              onTap: (){_handleSignIn(context);},
                                buttonText: 'Google', iconData:'assets/images/google.png')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(MainScreen());
                      },
                      child: Text(
                        'Continue as a Guest',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
