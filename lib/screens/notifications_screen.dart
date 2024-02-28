
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/colors.dart';
import '../model/notifications_response.dart';
import '../providers/auth_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context,listen: false).getNotifications();

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(padding: EdgeInsets.all(8),child: Text('Read all',style: TextStyle(color: kPurpleColor,fontWeight: FontWeight.bold),),)
        ],
        centerTitle: true,
        title: Text(
          'Notifications',
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
      body: Consumer<AuthProvider>(
        builder:(context, value, child) => Container(
          height: double.infinity,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                List.generate(value.notifications.length, (index) => NotificationItemWidget(notificationItem: value.notifications[index],))

            ),
          ),
        ),
      ),

    );
  }
}

class NotificationItemWidget extends StatelessWidget {
   NotificationItemWidget({super.key,required this.notificationItem});

  NotificationItem notificationItem;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(2).copyWith(left: 8),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png'),
        ),
        title: Text(
          notificationItem.title??'',
          style: TextStyle(
              color: Colors.black),
        ),
        subtitle: Text(
          notificationItem.content??'',
          style: TextStyle(
            fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black),
        ),
      
        onTap: () {
          // Add onTap functionality here
        },
      ),
    );
  }
}

