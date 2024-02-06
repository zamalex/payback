import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';
import 'contributer_screen.dart';


class CommitmentDetailsAnother extends StatelessWidget {
  CommitmentDetailsAnother({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,//Colors.grey.shade200,
      body:  Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //padding: EdgeInsets.all(10),

        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),gradient: LinearGradient(
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
                                InkWell(
                                    onTap:(){
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                                Expanded(child: Text('Back',style: TextStyle(color: Colors.white),)),

                              ],
                            ),
                          ),
                        ),
                        Container(

                          //margin: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top: 5,bottom: 10),
                          //height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),),
                          child: Column(children: [
                            Padding(
                              padding:  EdgeInsets.only(right: 15,left: 15,top:10,bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Row(
                                        children: [
                                          Icon(Icons.airplanemode_on_rounded, color: Colors.white),
                                          SizedBox(width: 8),
                                          Text(
                                            'Amazon Prime',
                                            style: TextStyle(fontSize: 20, color: Colors.white),
                                          ),
                                        ],
                                      )
                                  ),Text('', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)
                                ],
                              ),
                            ),
                          ],),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Commitment owner',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                 // SizedBox(height: 10,),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png'),
                    ),
                    title: Text(
                      'Alan Rahondy',
                      style: TextStyle(
                          color: Colors.black),
                    ),

                    onTap: () {
                      // Add onTap functionality here
                    },
                  ),


                  Padding(padding: EdgeInsets.all(10),child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          //color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: ClipPath(
                          clipper: BottomZigZagClipper(),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: double.infinity,
                            // height: 200.0,
                            decoration: BoxDecoration(
                              color: Colors.white,//Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)
                              ),
                            ),
                            child: Column(
                              children: [

                                ListTile(
                                  dense: true,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                                  visualDensity: VisualDensity(vertical: -4),
                                  leading: Icon(
                                    Icons.abc_sharp,
                                    color: kBlueColor,
                                  ),
                                  title: Text(
                                    'Unassigned cashback, SAR',
                                    style: TextStyle(fontSize: 15,color: kBlueColor,fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    '20 SAR',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(),
                                ListTile(
                                  dense: true,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                                  visualDensity: VisualDensity(vertical: -4),
                                  leading: Icon(
                                    Icons.abc_sharp,
                                    color: kBlueColor,
                                  ),
                                  title: Text(
                                    'Unassigned cashback, SAR',
                                    style: TextStyle(fontSize: 15,color: kBlueColor,fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    '20 SAR',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(),
ListTile(
                                  dense: true,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                                  visualDensity: VisualDensity(vertical: -4),
                                  leading: Icon(
                                    Icons.abc_sharp,
                                    color: kBlueColor,
                                  ),
                                  title: Text(
                                    'Unassigned cashback, SAR',
                                    style: TextStyle(fontSize: 15,color: kBlueColor,fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    '20 SAR',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),


                    ],),)
                ],
              )),
            ),


          ],
        ),

      ),

    );
  }
}

class ContributorWidget extends StatelessWidget{
  bool showDetails = true;

  ContributorWidget({this.showDetails = true});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(

        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png'),
        ),
        title: Text('Alan Rahondy',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        subtitle:!showDetails?null: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sharing 10% of cashback',style: TextStyle(color: Colors.black)),
            Text('32 SAR contributed',style: TextStyle(fontWeight: FontWeight.bold,color: kBlueColor)),
          ],
        ),
        onTap: () {
          Get.to(ContributerScreen());
        },
      ),
    );
  }


}
