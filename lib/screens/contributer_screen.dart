import 'package:flutter/material.dart';

import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';

class ContributerScreen extends StatelessWidget {
  ContributerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.blue.shade900,
                              Colors.blue.shade800,
                            ],
                          )),
                      child: Column(
                        children: [
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'Back',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            //margin: EdgeInsets.all(0),
                            padding: EdgeInsets.only(top: 5, bottom: 20),
                            //height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Icon(Icons.airplanemode_on_rounded,
                                              color: Colors.white),
                                          SizedBox(width: 8),
                                          Text(
                                            'Amazon Prime',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Commitment owner',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png'),
                            ),
                            title: Text(
                              'Alan Rahondy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sharing 10% of cashback',
                                    style: TextStyle(color: Colors.black)),
                                Text('32 SAR contributed',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kBlueColor)),
                              ],
                            ),
                            onTap: () {
                              // Add onTap functionality here
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'You sharing',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              Text(
                                '20% available',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.red[50]),
                              padding: EdgeInsets.all(4),
                              child: Center(
                                child: Text(
                                  '30%',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                ),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'You don’t have enought cashback % to share ',
                            style: TextStyle(fontSize: 15, color: Colors.red),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Total shared : 20 SAR',
                            style: TextStyle(
                                color: kBlueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Your commitments',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'To share more cashback with your friends, please, check your  current commitments and withdraw the percentage from them',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: List.generate(
                                4,
                                (index) => Container(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: Commitment())),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Container(
                  width: double.infinity,
                  child: CustomButton(
                      buttonText: 'Save changes',
                      buttonColor: kPurpleColor)),
            )
          ],
        ),
      ),
    );
  }
}
