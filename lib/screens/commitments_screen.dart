import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/screens/new_commitment_screen.dart';

class CommitmentsScreen extends StatelessWidget {
  const CommitmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
              label: Text('Back'),
            )),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My commitmetns',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: kBlueLightColor.withOpacity(.5),
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0.0),
                              visualDensity: VisualDensity(vertical: -4),
                              title: Text(
                                'Unassigned cashback, SAR',
                                style: TextStyle(fontSize: 15),
                              ),
                              trailing: Text(
                                '20 SAR',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Divider()

                            // ,SizedBox(height: 3,),
                            ,
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0.0),
                              visualDensity: VisualDensity(vertical: -4),
                              title: Text(
                                'Unassigned % ofcashback',
                                style: TextStyle(fontSize: 15),
                              ),
                              trailing: Text(
                                '20%',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )

                            // ,SizedBox(height: 3,),
                            ,
                            Divider()

                            // ,SizedBox(height: 3,),
                            ,
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0.0),
                              visualDensity: VisualDensity(vertical: -4),
                              title: Text(
                                'Commitments total, SAR',
                                style: TextStyle(fontSize: 15),
                              ),
                              trailing: Text(
                                '20 SAR',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Priority',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Edit order',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: kBlueColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: List.generate(
                            5,
                            (index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: Commitment())),
                      ),
                    ],
                  ),
                ),
              )),
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
                      buttonText: '+ Add new commitment',
                      buttonColor: kPurpleColor,
                      onTap: () {
                        Get.to(NewCommitmentScreen());
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
