import 'package:flutter/material.dart';

import '../helpers/colors.dart';
import 'my_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text(
          'Settings',
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
                  ProfileItem(text: 'Terms of Service',color: Colors.grey.shade800,onTap: (){},),
                  Divider(height: 30),

                  ProfileItem(text: 'Privacy policy',color: Colors.grey.shade800,onTap: (){}),
                  Divider(height: 30),

                  ProfileItem(text: 'Licenses',color: Colors.grey.shade800,onTap: (){}),
                  Divider(height: 30),

                  ProfileItem(text: 'Contact us',color: Colors.grey.shade800,showArrow: false,onTap: (){}),
                  Divider(height: 30),

                  ProfileItem(text: 'Rate us',color: Colors.grey.shade800,showArrow: false,onTap: (){}),

                ],),
              ),
            ),
            SizedBox(height: 20,),
            Container(width:double.infinity,child: Card(surfaceTintColor:Colors.white,color: Colors.white,child: Padding(padding: EdgeInsets.all(16),child: Text('Delete account',style: TextStyle(color: Colors.red),),),))
          ],
        ),
      ),
    );
  }
}
