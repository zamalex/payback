import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_widgets.dart';
import '../helpers/functions.dart';
import '../providers/auth_provider.dart';

class SMSScreen extends StatelessWidget {
  SMSScreen({Key? key,required this.request}) : super(key: key);

  TextEditingController controller = TextEditingController();

  Map<String,String> request;

  verify(BuildContext context){
    if (controller.text.isEmpty) {
      showErrorMessage(context, 'Enter required data');
      return;
    }

    request.putIfAbsent('otp', () => controller.text);

    print(request.toString());

    Provider.of<AuthProvider>(context, listen: false)
        .verify(request)
        .then((value) {
      value['data']==null?showErrorMessage(context, value['message'])
          :showSuccessMessage(context,value['message']);
    });
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
                      print(value);

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
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(buttonText: 'Confirm', buttonColor: kPurpleColor,onTap: (){verify(context);},)),
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

