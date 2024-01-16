import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/register.dart';

import '../helpers/custom_widgets.dart';

class PartnerInfoScreen extends StatelessWidget {
  const PartnerInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(),
        padding: EdgeInsets.all(0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Amazon prime',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Please, fill in the data that required to pay for this partner commitment'),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Enter your email',
                                style: TextStyle(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(hintText: 'Type email'),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                'Enter your name',
                                style: TextStyle(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(hintText: 'Type name'),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                'Amazon account ID',
                                style: TextStyle(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(hintText: 'Enter your ID'),
                        ]),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),

                child:   Container(
                    width: double.infinity,
                    child: CustomButton(buttonText: 'Continue', buttonColor: kPurpleColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
