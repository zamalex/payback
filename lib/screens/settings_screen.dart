import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../helpers/colors.dart';
import 'my_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  showSettingsDialog(String key,BuildContext context){
    final settings = Provider.of<AuthProvider>(context,listen: false).settingsResponse;

    if(settings==null){
        Provider.of<AuthProvider>(context,listen: false).getSettings().then((value){
          Get.defaultDialog(title:key.replaceAll('_', ' '),content: Flexible(
            child: SingleChildScrollView(
              child: Text(Provider.of<AuthProvider>(context,listen: false).settingsResponse!.data!.firstWhere((element) => element.key==key).value!,textAlign: TextAlign.center,),
            ),
          ),);
      });

    }
    else{
      Get.defaultDialog(title:key.replaceAll('_', ' '),content: Flexible(
        child: SingleChildScrollView(
          child: Text(Provider.of<AuthProvider>(context,listen: false).settingsResponse!.data!.firstWhere((element) => element.key==key).value!,
              textAlign: TextAlign.center,),
        ),
      ),);

    }

  }

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
                  ProfileItem(text: 'Terms of Service',color: Colors.grey.shade800,onTap: (){showSettingsDialog('terms_of_service',context);},),
                  Divider(height: 30),

                  ProfileItem(text: 'Privacy policy',color: Colors.grey.shade800,onTap: (){showSettingsDialog('privacy_policy',context);}),
                  Divider(height: 30),

                  ProfileItem(text: 'Licenses',color: Colors.grey.shade800,onTap: (){showSettingsDialog('licenses',context);}),
                  Divider(height: 30),

                  ProfileItem(text: 'Contact us',color: Colors.grey.shade800,showArrow: false,onTap: (){showSettingsDialog('contact_us',context);}),
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
