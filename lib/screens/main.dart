import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/providers/checkout_provider.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/checkout_screen.dart';
import 'package:payback/screens/commitments_screen.dart';
import 'package:payback/screens/commitmetn_details_screen.dart';
import 'package:payback/screens/contributer_screen.dart';
import 'package:payback/screens/email.dart';
import 'package:payback/screens/home_screen.dart';
import 'package:payback/screens/login.dart';
import 'package:payback/screens/main_screen.dart';
import 'package:payback/screens/new_commitment_screen.dart';
import 'package:payback/screens/partner_details_screen.dart';
import 'package:payback/screens/partner_info_screen.dart';
import 'package:payback/screens/phonenumber.dart';
import 'package:payback/screens/product_details_screen.dart';
import 'package:payback/screens/register.dart';
import 'package:payback/screens/saved_screen.dart';
import 'package:payback/screens/shop_online_screen.dart';
import 'package:payback/screens/splash.dart';

import 'package:provider/provider.dart';


import '../data/service_locator.dart';
import '../providers/auth_provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await init();


  runApp(MultiProvider(providers: [

      ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
      ChangeNotifierProvider<CheckoutProvider>(create: (_) => CheckoutProvider()),

    ], child: GetMaterialApp(home: const MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: AppBarTheme(backgroundColor: kBackgroundColor,),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CheckoutScreen(),
    );
  }
}


