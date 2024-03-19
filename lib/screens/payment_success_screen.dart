import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/main_screen.dart';

import '../helpers/custom_widgets.dart';

class PaymentSuccessScreen extends StatefulWidget {
   PaymentSuccessScreen({super.key,required this.data});

  Map data;

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {

  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));

    _controllerCenter.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Center(child: InkWell(child: Text('Close',style: TextStyle(color: kPurpleColor),),onTap: (){Get.offAll(MainScreen(index: 0,));},)),),
      body: Container(
        width: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [

               Expanded(child:  SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Image.asset('assets/images/success.png',width: 160,height: 160,),
                     SizedBox(height: 20,),
                     Text('Success',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                     SizedBox(height: 20,),
                     Text('Your order is accepted and will be delivered soon. Thank you for choosing our app!',style:TextStyle(fontSize: 18),textAlign: TextAlign.center,),
                     SizedBox(height: 20,),
                     Padding(padding: EdgeInsets.all(8),child: Column(
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

                                     title: Text(
                                       'Date & Time',
                                       style: TextStyle(fontSize: 15,color: Colors.black),
                                     ),
                                     trailing: Text(
                                       parseDate(widget.data['created_at']),
                                       style: TextStyle(
                                           fontSize: 15,
                                           color: Colors.grey,
                                           fontWeight: FontWeight.bold),
                                     ),
                                   ),
                                   Divider(),
                         ListTile(
                                     dense: true,
                                     contentPadding:
                                     EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                                     visualDensity: VisualDensity(vertical: -4),

                                     title: Text(
                                       'Total price',
                                       style: TextStyle(fontSize: 15,color: Colors.black),
                                     ),
                                     trailing: Text(
                                       '${widget.data['amount']??'--'} SAR',
                                       style: TextStyle(
                                           fontSize: 15,
                                           color: Colors.grey,
                                           fontWeight: FontWeight.bold),
                                     ),
                                   ),
                                   Divider(),
                         ListTile(
                                     dense: true,
                                     contentPadding:
                                     EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                                     visualDensity: VisualDensity(vertical: -4),

                                     title: Text(
                                       'Total cashbak',
                                       style: TextStyle(fontSize: 15,color: Colors.black),
                                     ),
                                     trailing: Text(
                                       '0 SAR',
                                       style: TextStyle(
                                           fontSize: 15,
                                           color: Colors.grey,
                                           fontWeight: FontWeight.bold),
                                     ),
                                   ),


                                 ],
                               ),
                             ),
                           ),
                         ),
                         SizedBox(height: 20,),
                         Text('More information about each order, order status and product details you can check in “My Orders” page. You can find this page in your Profile')
                         ,SizedBox(height: 10,),
                         Text('Go to My Orders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blue),)

                       ],),),


                   ],
                 ),
               ),),
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
                          buttonText: 'Go to Market', buttonColor: kPurpleColor,onTap: (){
                        Get.offAll(MainScreen(index: 1,));
                      },)),
                )
              ],
            ),

            ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.05,
              shouldLoop: false,
              colors: [
                kBlueColor,
                kPurpleColor
              ], // manually specify the colors to be used
            ),
          ],
        ),
      ),
    );
  }

  String parseDate(String s){
    DateTime dateTime = DateTime.parse(s);

    // Format the DateTime object into a readable format
    String formattedDateTime = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';

    return formattedDateTime;
  }
}
