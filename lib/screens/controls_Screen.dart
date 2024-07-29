import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/functions.dart';
import 'package:payback/model/auth_response.dart';
import 'package:payback/screens/commitments_screen.dart';
import 'package:payback/screens/help_community_screen.dart';
import 'package:payback/screens/history_screen.dart';
import 'package:provider/provider.dart';

import '../data/service_locator.dart';
import '../providers/CommitmentsProvider.dart';

class ControlsScreen extends StatelessWidget {
  const ControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<CommitmentsProvider>(context,listen: false).getCommitmentsCategories();

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Controls',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
           ControlsItem(image: 'assets/images/bill.png',color: kPurpleColor,text: 'Commitments',onTap: (){
             if(sl.isRegistered<AuthResponse>()){
               Get.to(CommitmentsScreen());
             }else{
               showGoToLogin();
             }
           },),
           ControlsItem(image: 'assets/images/pie.png',color: kBlueColor,text: 'Cashback dashboard',onTap: (){
             if(sl.isRegistered<AuthResponse>()){
               Get.to(HistoryScreen());
             }else{
               showGoToLogin();
             }
             },),
           ControlsItem(image: 'assets/images/group.png',color: Color.fromRGBO(10, 91, 148, 1),text: 'Help community',onTap: (){

             if(sl.isRegistered<AuthResponse>()){
               Get.to(HelpCommunityScreen());
             }else{
               showGoToLogin();
             }
           },),

          ],
        ),
      ),
    );
  }
}


class ControlsItem extends StatelessWidget {
   ControlsItem({super.key,required this.text,required this.color,required this.image,required this.onTap});
  Function onTap;
  String text;
  String image;
  Color color;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: color,width: .5),
                  color: color.withOpacity(.1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(image,width: 82,height: 82,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      text,

                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: color),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(child: Icon(Icons.arrow_forward,color: kBlueColor,),right: 10,top: 10,)
          ],
        ),
      ),
    );
  }
}

