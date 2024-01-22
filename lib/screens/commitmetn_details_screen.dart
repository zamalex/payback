import 'package:flutter/material.dart';

import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';


class CommitmetDetails extends StatelessWidget {
  CommitmetDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
                                    Icon(Icons.arrow_back_ios,color: Colors.white,),
                                    Expanded(child: Text('Back',style: TextStyle(color: Colors.white),)),
                                    Icon(Icons.edit,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Icon(Icons.delete,color: Colors.white,),
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
                                                'Amazon Prime',
                                                style: TextStyle(fontSize: 20, color: Colors.white),
                                              ),
                                            ],
                                          )
                                      ),Text('20 SAR', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)
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
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      trailing: Text(
                                        '20 SAR',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kBlueColor,
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
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      trailing: Text(
                                        '20 SAR',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kBlueColor,
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
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      trailing: Text(
                                        '20 SAR',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kBlueColor,
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
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      trailing: Text(
                                        '20 SAR',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kBlueColor,
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
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      trailing: Text(
                                        '20 SAR',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kBlueColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
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
                          Container(width:double.infinity,child: CustomButton(buttonText: 'Share commitment', buttonColor: kBlueColor)),
                          SizedBox(height: 20,),
                          Text('Commitment contributors',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Column(
                            children:  List.generate(2, (index) => ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png'),
                              ),
                              title: Text('Alan Rahondy',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Sharing 10% of cashback',style: TextStyle(color: Colors.black)),
                                  Text('32 SAR contributed',style: TextStyle(fontWeight: FontWeight.bold,color: kBlueColor)),
                                ],
                              ),
                              onTap: () {
                                // Add onTap functionality here
                              },
                            )),
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
