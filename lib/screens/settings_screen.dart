import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/data/repository/auth_repo.dart';
import 'package:payback/data/service_locator.dart';
import 'package:payback/providers/auth_provider.dart';
import 'package:payback/screens/login.dart';
import 'package:provider/provider.dart';

import '../helpers/colors.dart';
import 'my_profile_screen.dart';
showSettingsDialog(String key, BuildContext context,{String? details}) {
  final settings =
      Provider.of<AuthProvider>(context, listen: false).settingsResponse;

  if(details!=null){
    Get.defaultDialog(
      title: key.replaceAll('_', ' '),
      content: Flexible(
        child: SingleChildScrollView(
          child: Text(
            details,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    return;
  }
  if (settings == null) {
    Provider.of<AuthProvider>(context, listen: false)
        .getSettings()
        .then((value) {
      Get.defaultDialog(
        title: key.replaceAll('_', ' '),
        content: Flexible(
          child: SingleChildScrollView(
            child: Text(
              Provider.of<AuthProvider>(context, listen: false)
                  .settingsResponse!
                  .data!
                  .firstWhere((element) => element.key == key)
                  .value!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  } else {
    Get.defaultDialog(
      title: key.replaceAll('_', ' '),
      content: Flexible(
        child: SingleChildScrollView(
          child: Text(
            Provider.of<AuthProvider>(context, listen: false)
                .settingsResponse!
                .data!
                .firstWhere((element) => element.key == key)
                .value!,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ProfileItem(
                      text: 'Terms of Service',
                      color: Colors.grey.shade800,
                      onTap: () {
                        showSettingsDialog('terms_of_service', context);
                      },
                    ),
                    Divider(height: 30),
                    ProfileItem(
                        text: 'Privacy policy',
                        color: Colors.grey.shade800,
                        onTap: () {
                          showSettingsDialog('privacy_policy', context);
                        }),
                    Divider(height: 30),
                    ProfileItem(
                        text: 'Licenses',
                        color: Colors.grey.shade800,
                        onTap: () {
                          showSettingsDialog('licenses', context);
                        }),
                    Divider(height: 30),
                    ProfileItem(
                        text: 'Contact us',
                        color: Colors.grey.shade800,
                        showArrow: false,
                        onTap: () {
                          showSettingsDialog('contact_us', context);
                        }),
                    Divider(height: 30),
                    ProfileItem(
                        text: 'Rate us',
                        color: Colors.grey.shade800,
                        showArrow: false,
                        onTap: () {}),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  showDeleteDialog(context);
                },
                child: Container(
                    width: double.infinity,
                    child: Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Delete account',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}

showDeleteDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Delete"),
    onPressed: () {
      sl<AuthRepository>().deleteAccount().then((v) {
        sl<PreferenceUtils>().logout();
        Get.to(LoginScreen());
      });
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Careful"),
    content: Text("Would you like to continue deleting your account?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
