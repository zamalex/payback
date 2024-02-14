import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/screens/help_details_screen.dart';

import '../helpers/colors.dart';

class HelpCommunityScreen extends StatelessWidget {
  const HelpCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/auth_background.png',
                ),
                fit: BoxFit.cover)),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
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
            SizedBox(
              height: 20,
            ),
            Text(
              'Help community',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: kBlueColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total cashback sharing',
                    style: TextStyle(color: kBlueColor, fontSize: 18),
                  ),
                  Text(
                    '60%',
                    style: TextStyle(
                        color: kBlueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 8,crossAxisCount: 2,childAspectRatio: .7), itemBuilder:(context, index) {
              return CommunityItem();
            },itemCount: 4,))
          ],
        ),
      ),
    );
  }
}

class CommunityItem extends StatelessWidget {
  const CommunityItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(HelpDetailsScreen());
      },
      child: Card(
        elevation: 2,
        color: Colors.white,
        surfaceTintColor: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15))),

        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CircleAvatar(backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVR9V1Ix26V2s_WWWryH3FU5Qkl2yR4PL3BcUybf2cUw&s',),radius: 50,)
              ,SizedBox(height: 20,),
              Text(
                'Help community',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                    color: kBlueColor.withOpacity(.2),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(2).copyWith(left: 8,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'To user',
                      style: TextStyle(color: kBlueColor, fontSize: 15),
                    ),
                    Text(
                      '60%',
                      style: TextStyle(
                          color: kBlueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(218, 189, 208, .5),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(2).copyWith(left: 8,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'From user',
                      style: TextStyle(color: kPurpleColor, fontSize: 15),
                    ),
                    Text(
                      '60%',
                      style: TextStyle(
                          color: kPurpleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}