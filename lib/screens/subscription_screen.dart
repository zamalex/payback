import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/providers/auth_provider.dart';
import 'package:payback/screens/subscribe_payment_screen.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../helpers/colors.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<AuthProvider>(context, listen: false).getPlans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Subscription',
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
        builder: (context, value, child) => Container(
          height: double.infinity,
          padding: EdgeInsets.all(16),
          child: value.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : value.plans.isEmpty
                  ? Center(
                      child: Text('No plans available'),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SlideSwitcher(
                                  containerColor: Colors.white,
                                  slidersColors: const [
                                    kBlueColor,
                                  ],
                                  containerBorder:
                                      Border.all(color: Colors.white, width: 5),
                                  children: [
                                    Text(
                                      value.plans[0].planName,
                                      style: TextStyle(
                                          color: selected == 0
                                              ? Colors.white
                                              : kBlueColor),
                                    ),
                                    Text(
                                      value.plans[1].planName,
                                      style: TextStyle(
                                          color: selected == 1
                                              ? Colors.white
                                              : kBlueColor),
                                    ),
                                  ],
                                  onSelect: (index) {
                                    setState(() {
                                      selected = index;
                                    });
                                  },
                                  containerHeight: 45,
                                  containerWight:
                                      MediaQuery.of(context).size.width -
                                          32 -
                                          10,
                                ),
                                Container(height: 20),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: kBlueColor.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/payback_logo.png',
                                        color: kBlueColor,
                                        width: 214,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Subscribe to Payback',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${subscribe}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${value.plans[selected].price} SAR/${value.plans[selected].planName}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: kBlueColor),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      value.plans[selected].isSubscribed
                                          ? Container()
                                          : Container(
                                              width: double.infinity,
                                              child: CustomButton(
                                                buttonColor: kPurpleColor,
                                                buttonText: 'Subscribe now',
                                                onTap: () {
                                                  Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false)
                                                      .subscribeToPlan({
                                                    'subscription_id': value
                                                        .plans[selected].id,
                                                    'order_id': value
                                                        .plans[selected].id,
                                                    'order_amount': value
                                                        .plans[selected].price,
                                                  }).then((v) {
                                                    if (v['data'] == null) {
                                                      Get.snackbar('Alert',
                                                          v['message']);

                                                      return;
                                                    }
                                                    /*Get.back();
                                            Get.snackbar('Alert', v['message']);*/
                                                    Get.to(PaymentScreen(
                                                        url: v['data']));
                                                  });
                                                },
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        CustomRichText()
                      ],
                    ),
        ),
      ),
    );
  }

  String subscribe =
      'Get maximum from one subscription:\n\t• Increased cashback from partners\n • Premium support from Payback team\n • Some other premium feature';
}

class CustomRichText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: 'By subscribing you automatically agree with our ',
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(color: Colors.blue),
          ),
          TextSpan(
            text: ' and ',
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: 'Terms & Conditions',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
