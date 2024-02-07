import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';
class EditEmailScreen extends StatelessWidget {
  const EditEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        title: Text('Edit email',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: TextButton.icon(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: kPurpleColor,), label: Text('Back',style: TextStyle(color: kPurpleColor),)),
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),

                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Text('Your email'),
                        SizedBox(height: 5,),
                        CustomTextField(hintText: 'mmm@yahoo.com'),
                        SizedBox(height: 10,),
                        Text('Your password'),
                        SizedBox(height: 5,),
                        CustomTextField(hintText: 'Enter password',obscureText: true)
                        ,SizedBox(height: 20,),

                        Container(
                            width:double.infinity,child: CustomButton(buttonText: 'Save changes', buttonColor: kPurpleColor)),

                  SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Forgot password?',style: TextStyle(color: kPurpleColor,fontWeight: FontWeight.bold),),
                  ],
                ),


                      ],),
                    ],),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
