import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/screens/edit_email_screen.dart';
import 'package:payback/screens/edit_name_screen.dart';
import 'package:payback/screens/edit_password_screen.dart';

import '../helpers/colors.dart';
import 'my_profile_screen.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text(
          'Ptofile info',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leadingWidth: 100,
        leading: TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kPurpleColor,
            ),
            label: Text(
              'Back',
              style: TextStyle(color: kPurpleColor),
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              surfaceTintColor: Colors.white,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  ProfileItem(text: 'Edit email',color: Colors.grey.shade800,onTap: (){
                    Get.to(EditEmailScreen());
                  },),
                  Divider(height: 30),

                  ProfileItem(text: 'Edit password',color: Colors.grey.shade800,onTap: (){
                    Get.to(EditPasswordScreen());

                  }),
                  Divider(height: 30),

                  ProfileItem(text: 'Edit name',color: Colors.grey.shade800,onTap: (){
                    Get.to(EditNameScreen());

                  }),


                ],),
              ),
            ),
             ],
        ),
      ),
    );
  }
}
