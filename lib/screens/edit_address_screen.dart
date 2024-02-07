import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';
class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        title: Text('Shipping address',style: TextStyle(fontWeight: FontWeight.bold),),
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
                    Text('Enter your delivery address',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      SizedBox(height: 20,),

                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Text('City'),
                        SizedBox(height: 5,),
                        CustomTextField(hintText: 'Choose your city'),
                        SizedBox(height: 10,),
                        Text('Street'),
                        SizedBox(height: 5,),
                        CustomTextField(hintText: 'Choose your street')
                        ,SizedBox(height: 10,),

                        Row(children: [
                          Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('Building'),
                            SizedBox(height: 5,),
                            CustomTextField(hintText: 'Building N')],)),
                          SizedBox(width: 15,),
                          Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('Apartment'),
                            SizedBox(height: 5,),
                            CustomTextField(hintText: 'Apartment N')],))
                        ],),



                      ],),
                  ],),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),
              child: Container(
                  width:double.infinity,child: CustomButton(buttonText: 'Save changes', buttonColor: kPurpleColor)),
            )
          ],
        ),
      ),
    );
  }
}
