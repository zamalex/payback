import 'package:flutter/material.dart';
import 'package:payback/screens/commitments_screen.dart';
import 'package:payback/screens/commitmetn_details_screen.dart';
import 'package:payback/screens/contributer_screen.dart';
import 'package:payback/screens/email.dart';

import 'package:payback/screens/onboarding.dart';
import 'package:payback/screens/phonenumber.dart';
import 'package:payback/screens/register.dart';
import 'package:payback/screens/smsverify.dart';
import 'package:payback/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CommitmetDetails(),
    );
  }
}


