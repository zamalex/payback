import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';
class EditNameScreen extends StatelessWidget {
  const EditNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        title: Text('Edit name',style: TextStyle(fontWeight: FontWeight.bold),),
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
                        Text('First name'),
                        SizedBox(height: 5,),
                        CustomTextField(hintText: 'Enter first name',obscureText: false,),
                        SizedBox(height: 10,),
                        Text('Last name'),
                        SizedBox(height: 5,),
                        CustomTextField(hintText: 'Enter last name',obscureText: false,)
                        ,SizedBox(height: 20,),

                        Container(
                            width:double.infinity,child: CustomButton(buttonText: 'Save changes', buttonColor: kPurpleColor)),

                        SizedBox(height: 20,),




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
