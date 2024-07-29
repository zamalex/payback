
import 'package:flutter/material.dart';

import '../helpers/colors.dart';

class NotificationsSettingsScreen extends StatelessWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text(
          'Notification settings',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Turn on/off notifications about different actions in Payback app.',style: TextStyle(color: Colors.grey.shade700,fontSize: 18),)
            ,SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kBlueLightColor.withOpacity(.5)),
              padding: EdgeInsets.all(4),
              child: SwitchListTile(
                trackColor: MaterialStateProperty.all(Colors.green),
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white,
                title: Text(
                  'Commitment ready to be payed',
                  style: TextStyle(
                      color: kBlueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                value: true,
                onChanged: (bool value) {},
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kBlueLightColor.withOpacity(.5)),
              padding: EdgeInsets.all(4),
              child: SwitchListTile(
                trackColor: MaterialStateProperty.all(Colors.green),
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white,
                title: Text(
                  'Friend shared cashback',
                  style: TextStyle(
                      color: kBlueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                value: true,
                onChanged: (bool value) {},
              ),
            ),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kBlueLightColor.withOpacity(.5)),
              padding: EdgeInsets.all(4),
              child: SwitchListTile(
                trackColor: MaterialStateProperty.all(Colors.green),
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white,
                title: Text(
                  'Order status notifications',
                  style: TextStyle(
                      color: kBlueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                value: true,
                onChanged: (bool value) {},
              ),
            ),
          ],
        ),
      ),

    );
  }
}
