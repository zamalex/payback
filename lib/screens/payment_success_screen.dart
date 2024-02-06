import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';

import '../helpers/custom_widgets.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Center(child: InkWell(child: Text('Close',style: TextStyle(color: kPurpleColor),),onTap: (){Get.back();},)),),
      body: Container(
        width: MediaQuery.of(context).size.height,
        child: Column(
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
                                   '18.09.2023; 12:23',
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
                                   '21 630,39 SAR',
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
                                   '229,7 SAR',
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
                      buttonText: 'Go to Market', buttonColor: kPurpleColor)),
            )
          ],
        ),
      ),
    );
  }
}
