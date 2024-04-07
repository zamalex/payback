import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/data/http/urls.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/model/orders_model.dart';
import 'package:payback/providers/checkout_provider.dart';
import 'package:payback/screens/commitment_category_received.dart';
import 'package:provider/provider.dart';

import '../helpers/functions.dart';

class OrderDetails extends StatelessWidget {
   OrderDetails({super.key,this.order});

   Order? order;

   Map statues = {'1':'Completed','2':'Cancelled','0':'Pending',};
   Map statusColors = {'1':Colors.green,'2':Colors.red,'0':Colors.amber,};

  @override
  Widget build(BuildContext context) {
    order = order ?? Order.fromJson(jsonDecode(Url.STATIC_ORDER));

    return Scaffold(
      appBar: AppBar(
        leading:  BackButton(),
        title: Text('Order details'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReceivedItem(order: order!,),
              Text('General information',style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container(padding:EdgeInsets.all(16),decoration: BoxDecoration(color: kBlueColor.withOpacity(.2),borderRadius: BorderRadius.circular(15)),child: Column(children: [
                LeadingTrailingItem(txt: 'Date & Time', widget: Text('${parseDate(order!.dateTime!)}',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
                ,SizedBox(height: 5,),
                Divider()
                ,SizedBox(height: 5,),
                LeadingTrailingItem(txt: 'Status', widget: Text('${statues[order!.status]}',style: TextStyle(color:statusColors[order!.status],fontWeight: FontWeight.bold),))
              ,SizedBox(height: 5,),
              Divider()
              ,SizedBox(height: 5,),
                LeadingTrailingItem(txt: 'Tracking number', widget: Text('${order!.id}',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))


              ],),)
              ,SizedBox(height: 20,),
              Text('Shipping information',style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container(padding:EdgeInsets.all(16),decoration: BoxDecoration(color: kBlueColor.withOpacity(.2),borderRadius: BorderRadius.circular(15)),child: Column(children: [
                LeadingTrailingItem(txt: 'Delivery method', widget:Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPdRZh8TJiJxxdkvyg61IBHGiVQgQZhm62YXJb_YPeRQ&s',width: 60,height: 20,),
                )
                ,SizedBox(height: 5,),
                Divider()
                ,SizedBox(height: 5,),
                LeadingTrailingItem(txt: 'Pick up', widget: Text('Self pick up',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
                ,SizedBox(height: 5,),
                Divider()
                ,SizedBox(height: 5,),
                LeadingTrailingItem(txt: 'Office', widget: Text('${order!.pickupOffice}',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
  ,SizedBox(height: 5,),
                Divider()
                ,SizedBox(height: 5,),
                LeadingTrailingItem(txt: 'Name', widget: Text('${order!.userName}',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
  ,SizedBox(height: 5,),
                Divider()
                ,SizedBox(height: 5,),
                LeadingTrailingItem(txt: 'Phone', widget: Text('${order!.userPhone}',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))


              ],),),
          SizedBox(height: 20,),
      Text('Order summary',style: TextStyle(fontWeight: FontWeight.bold),),
      SizedBox(height: 20,),
      Container(padding:EdgeInsets.all(16),decoration: BoxDecoration(color: kBlueColor.withOpacity(.2),borderRadius: BorderRadius.circular(15)),child: Column(children: [
       
          LeadingTrailingItem(txt: 'Quantity', widget: Text('${order!.quantity}',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
          ,SizedBox(height: 5,),
          Divider()
          ,SizedBox(height: 5,),
          LeadingTrailingItem(txt: 'Price', widget: Text('${order!.totalPrice} SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
          ,SizedBox(height: 5,),
          Divider()
          ,SizedBox(height: 5,),
          LeadingTrailingItem(txt: 'Cashback', widget: Text('0 SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
          ,SizedBox(height: 5,),
          Divider()
          ,SizedBox(height: 5,),
          LeadingTrailingItem(txt: 'Delivery', widget: Text('${order!.deliveryMethod}',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))

          ,SizedBox(height: 10,)


      ],),),

            if(order!.status=='0')
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              child: CustomButton(buttonText: 'Cancel', buttonColor: Colors.red,textColor: Colors.white,onTap: (){
                    Provider.of<CheckoutProvider>(context,listen: false).cancelOrder({'status':2},int.parse(order!.orderId!)).then((value){
                      Provider.of<CheckoutProvider>(context,listen: false).loadOrders();
                      Get.back();
                    });

                    },),
            )
            ],
          ),
        ),
      ),
    );
  }
}


class LeadingTrailingItem extends StatelessWidget {
   LeadingTrailingItem({super.key,required this.txt,required this.widget});
   String txt;
   Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
        Text(txt),
        widget
      ],),
    );
  }
}
