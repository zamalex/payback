import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/smsverify.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_widgets.dart';
import '../helpers/functions.dart';
import '../providers/auth_provider.dart';

class CheckPhoneNumberScreen extends StatelessWidget {
   CheckPhoneNumberScreen({Key? key,required this.request}) : super(key: key);

  Map<String,String> request;

   TextEditingController phnoneController = TextEditingController();

   register(BuildContext context){
     if(phnoneController.text.isEmpty){
       showErrorMessage(context, 'Enter required data');
       return;
     }



     request.putIfAbsent('phone', () => phnoneController.text);
     request.putIfAbsent('is_vendor', () => "0");


     Provider.of<AuthProvider>(context,listen: false).register(request).then((value) {
       if(value['data']){
         Get.to(SMSScreen());
       }else{
         showErrorMessage(context, value['message']);

       }
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
                  CustomTextField(hintText: 'Enter your phone number',controller: phnoneController,),

                  SizedBox(height: 20,),
                  Consumer<AuthProvider>(
                    builder:(context,value,child)=> value.isLoading?CircularProgressIndicator():Container(
                        width: MediaQuery.of(context).size.width,
                        child: CustomButton(buttonText: 'Send', buttonColor: kPurpleColor,onTap: (){
                          register(context);
                        },)),
                  ),
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

