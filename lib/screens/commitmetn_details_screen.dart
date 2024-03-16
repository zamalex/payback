import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payback/model/auth_response.dart';
import 'package:payback/providers/CommitmentsProvider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../data/service_locator.dart';
import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';
import '../providers/home_provider.dart';
import 'contributer_screen.dart';
import 'package:payback/model/commitment_model.dart' as model;


class CommitmetDetails extends StatelessWidget {
  CommitmetDetails({super.key,required this.commitment});

  model.Commitment commitment;




  shareCommitment(BuildContext context){

    int user = sl<AuthResponse>().data!.user!.id!;

    Provider.of<CommitmentsProvider>(context,listen: false).sendInvitation({
      'commitment_id':commitment.id,
      'user_id':user
    });
  }

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
                                    Icon(Icons.edit,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    InkWell(
                                        onTap: (){
                                          Provider.of<CommitmentsProvider>(context,listen: false).deleteCommitment(commitment.id!).then((value){
                                            Provider.of<HomeProvider>(context,listen: false).getCommitments();
                                            Get.back();
                                            Get.snackbar(value['data']?'Success':'Error', value['message'],backgroundColor: value['data']?Colors.green:Colors.red,colorText: Colors.white,);

                                          });
                                        },
                                        child: Icon(Icons.delete,color: Colors.white,)),
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
                                  padding:  EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                            children: [
                                              Icon(Icons.airplanemode_on_rounded, color: Colors.white),
                                              SizedBox(width: 8),
                                              Text(
                                                commitment.name??'',
                                                style: TextStyle(fontSize: 20, color: Colors.white),
                                              ),
                                            ],
                                          )
                                      ),Text('${commitment.paymentTarget??'0'} SAR', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)
                                    ],
                                  ),
                                ),
                                Container(

                                  width: double.maxFinite,
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                        thumbShape: CustomThumbShape()
                                    ),
                                    child: Slider(
                                      activeColor: Colors.teal,

                                      min: 0.0,
                                      max: 100.0,
                                      value: 20,
                                      // divisions: 10,
                                      label: '20',
                                      onChanged: (value) {

                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('100% collected',style: TextStyle(fontSize: 12,color: Colors.white)),
                                      Text('100% collected',style: TextStyle(fontSize: 12,color: Colors.white)),
                                    ],
                                  ),
                                )
                              ],),
                            )
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(15),child: Column(
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
                                      horizontalTitleGap: 0,
                                      dense: true,
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                                      visualDensity: VisualDensity(vertical: -4),
                                      leading: Image.asset('assets/images/sadad.png',width: 15,height: 15,),
                                      title: Text(
                                        'SADAD',
                                        style: TextStyle(fontSize: 15,color: kBlueColor,fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(
                                        '20123456844',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Divider(),
                                    ListTile(
                                      horizontalTitleGap: 0,
                                      dense: true,
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                                      visualDensity: VisualDensity(vertical: -4),
                                      leading: Image.asset('assets/images/payment_sum.png',width: 15,height: 15,),
                                      title: Text(
                                        'Payment sum',
                                        style: TextStyle(fontSize: 15,color: kBlueColor,fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(
                                        '300 SAR',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Divider(),
                                    ListTile(
                                      horizontalTitleGap: 0,
                                      dense: true,
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                                      visualDensity: VisualDensity(vertical: -4),
                                      leading: Image.asset('assets/images/percentage.png',width: 15,height: 15,),
                                      title: Text(
                                        'Cashback to commitment',
                                        style: TextStyle(fontSize: 15,color: kBlueColor,fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(
                                        '20%',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Divider(),
                                    ListTile(
                                      horizontalTitleGap: 0,
                                      dense: true,
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                                      visualDensity: VisualDensity(vertical: -4),
                                      leading: Image.asset('assets/images/calendar.png',width: 15,height: 15,),
                                      title: Text(
                                        'Due date',
                                        style: TextStyle(fontSize: 15,color: kBlueColor,fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(
                                        '27.07.2023',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Divider(),
                                    ListTile(
                                      horizontalTitleGap: 0,
                                      dense: true,
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                                      visualDensity: VisualDensity(vertical: -4),
                                      leading: Image.asset('assets/images/categories.png',width: 15,height: 15,),
                                      title: Text(
                                        'Category',
                                        style: TextStyle(fontSize: 15,color: kBlueColor,fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(
                                        'Home bills',
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
                          SizedBox(height: 20,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: kBlueLightColor.withOpacity(.5)
                            ),
                            padding: EdgeInsets.all(4),
                            child:   SwitchListTile(
                              trackColor: MaterialStateProperty.all(Colors.green),
                              activeColor: Colors.white,
                              inactiveThumbColor: Colors.white,
                              title: Text('Notify me about goal completion',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold,fontSize: 15),),
                              value: true,
                              onChanged: (bool value) {

                              },
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(width:double.infinity,child: CustomButton(buttonText: 'Share commitment', buttonColor: kBlueColor,onTap: (){
                            Share.share('check out my invitation to share my commitment https://payback.example.com?id=11');
                          },)),
                          SizedBox(height: 20,),
                          Text('Commitment contributors',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Column(
                            children:  List.generate(2, (index) => ContributorWidget()),
                          )
                          ,
                          ],),)
                    ],
                  )),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),
                  child: Container(
                      width:double.infinity,child: CustomButton(buttonText: 'Pay', buttonColor: kPurpleColor)),
                )

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
