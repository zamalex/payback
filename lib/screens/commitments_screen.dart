import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/model/auth_response.dart';
import 'package:payback/providers/auth_provider.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/login.dart';
import 'package:payback/screens/new_commitment_screen.dart';
import 'package:payback/screens/reorder_screen.dart';
import 'package:provider/provider.dart';

import '../data/service_locator.dart';

class CommitmentsScreen extends StatefulWidget {
  const CommitmentsScreen({super.key});

  @override
  State<CommitmentsScreen> createState() => _CommitmentsScreenState();
}

class _CommitmentsScreenState extends State<CommitmentsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<AuthProvider>(context,listen: false).getCashback();
  }

  double commitmentsTotal(){
    double total  = 0;

    Provider.of<HomeProvider>(context,listen: false).commitments.forEach((element) {
      total+= double.parse(element.paymentTarget??'0');
    });

    return total;
  }
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
                        'My commitments',
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
                        child: Consumer<AuthProvider>(
                          builder:(context, value, child) => Column(
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
                                  '${value.cashbackModel.depositUnsignedBalance} SAR',
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
                                  '${((value.cashbackModel.depositAssignedBalance/value.cashbackModel.depositUnsignedBalance)).isNaN||((value.cashbackModel.depositAssignedBalance/value.cashbackModel.depositUnsignedBalance)).isInfinite?0:((((value.cashbackModel.depositAssignedBalance/value.cashbackModel.depositUnsignedBalance)))*100).toStringAsFixed(2)}%',
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
                                  '${commitmentsTotal()} SAR',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: kBlueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
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
                          InkWell(
                            onTap: (){
                              Get.to(ReorderScreen());
                            },
                            child: Text(
                              'Edit order',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: kBlueColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Consumer<HomeProvider>(
                        builder:(context, value, child) => Column(
                          children: List.generate(
                              value.commitments.length,
                              (index) => Container(
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  child: Commitment(commitment: value.commitments[index],))),
                        ),
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
                        if(sl.isRegistered<AuthResponse>()){
                          Get.to(NewCommitmentScreen());

                        }
                        else{
                          Get.snackbar('Authentication required', 'please login first',backgroundColor: Colors.red,colorText: Colors.white);

                          Get.to(LoginScreen());

                        }
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
