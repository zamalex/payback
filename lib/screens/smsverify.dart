import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/login.dart';
import 'package:payback/screens/reset_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_widgets.dart';
import '../helpers/functions.dart';
import '../providers/auth_provider.dart';

class SMSScreen extends StatefulWidget {
  SMSScreen({Key? key,required this.request,this.isRegister=true}) : super(key: key);

  bool isRegister = true;
  Map<String,String> request;

  @override
  State<SMSScreen> createState() => _SMSScreenState();
}

class _SMSScreenState extends State<SMSScreen> {
  bool clickable = false;

  TextEditingController controller = TextEditingController();

  verify(BuildContext context){
    if (controller.text.isEmpty) {
      showErrorMessage(context, 'Enter required data');
      return;
    }
    if(widget.isRegister){
      widget.request.putIfAbsent('otp', () => controller.text);

      print(widget.request.toString());

      Provider.of<AuthProvider>(context, listen: false)
          .verify(widget.request)
          .then((value) {
        value['data']==null?showErrorMessage(context, value['message'])
            :showSuccessMessage(context,value['message']);
        if(value['data']!=null){
          Get.to(LoginScreen());
        }
      });
    }
    else{
      widget.request.putIfAbsent('token', () => controller.text);

      print(widget.request.toString());

      Provider.of<AuthProvider>(context, listen: false)
          .checkForgotToken(widget.request)
          .then((value) {
        value['data']==false?showErrorMessage(context, value['message'])
            :showSuccessMessage(context,value['message']);
        if(value['data']){
          Get.to(ResetScreen(request: widget.request));
        }
      });
    }


  }

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
                Text('Enter code from SMS',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),

                SizedBox(height: 30,),

                Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    length: 4,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(

                      selectedFillColor: Colors.white,
                      selectedColor: Colors.grey,
                      disabledColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.grey,
                      shape: PinCodeFieldShape.box,
                      borderWidth: 1,
                      borderRadius: BorderRadius.circular(16),
                      fieldHeight: 48,
                      fieldWidth: 56,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,

                    //errorAnimationController: errorController,
                   // controller: controller,
                    onCompleted: (v) {
                      //otp=v;
                      print("Completed");
                    },
                    onChanged: (value) {
                      if(controller.text.length==4){
                        setState(() {
                          clickable = true;
                        });
                      }
                  else{
                        setState(() {
                          clickable = false;
                        });
                      }
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    }, appContext: context,
                  ),
                ),

                SizedBox(height: 20,),
                Consumer<AuthProvider>(
                  builder:(context, value, child) => value.isLoading?Center(child: CircularProgressIndicator(),): Container(
                      width: MediaQuery.of(context).size.width,
                      child: Opacity(opacity:clickable?1:.4,child: CustomButton(buttonText: 'Confirm', buttonColor: kPurpleColor,onTap: (){

                        if(!clickable)
                          return;
                        verify(context);},))),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Haven’t received the code?'),
                    SizedBox(width: 5,),
                    Text('Resend',style: TextStyle(fontWeight: FontWeight.bold,color: kBlueColor),),
                  ],
                ),


              ]
          ),
        ),
      ),
    );
  }
}

