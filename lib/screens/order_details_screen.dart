import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/commitment_category_received.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  BackButtonIcon(),
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
              ReceivedItem(),
              Text('General information',style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container(padding:EdgeInsets.all(16),decoration: BoxDecoration(color: kBlueColor.withOpacity(.2),borderRadius: BorderRadius.circular(15)),child: Column(children: [
                LeadingTrailingItem(txt: 'Date & Time', widget: Text('05.06.2023; 17:32',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
                ,SizedBox(height: 5,),
                Divider()
                ,SizedBox(height: 5,),
                LeadingTrailingItem(txt: 'Status', widget: Text('Completed',style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold),))
              ,SizedBox(height: 5,),
              Divider()
              ,SizedBox(height: 5,),
                LeadingTrailingItem(txt: 'Tracking number', widget: Text('10994513651',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))


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
                LeadingTrailingItem(txt: 'Office', widget: Text('City, Street, Building. Truncate...',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
  ,SizedBox(height: 5,),
                Divider()
                ,SizedBox(height: 5,),
                LeadingTrailingItem(txt: 'Name', widget: Text('Salim Lambertson',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
  ,SizedBox(height: 5,),
                Divider()
                ,SizedBox(height: 5,),
                LeadingTrailingItem(txt: 'Phone', widget: Text('+10994513651',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))


              ],),),
          SizedBox(height: 20,),
      Text('Order summary',style: TextStyle(fontWeight: FontWeight.bold),),
      SizedBox(height: 20,),
      Container(padding:EdgeInsets.all(16),decoration: BoxDecoration(color: kBlueColor.withOpacity(.2),borderRadius: BorderRadius.circular(15)),child: Column(children: [
       
          LeadingTrailingItem(txt: 'Quantity', widget: Text('1',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
          ,SizedBox(height: 5,),
          Divider()
          ,SizedBox(height: 5,),
          LeadingTrailingItem(txt: 'Price', widget: Text('912,5 SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
          ,SizedBox(height: 5,),
          Divider()
          ,SizedBox(height: 5,),
          LeadingTrailingItem(txt: 'Cashback', widget: Text('912,5 SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))
          ,SizedBox(height: 5,),
          Divider()
          ,SizedBox(height: 5,),
          LeadingTrailingItem(txt: 'Delivery', widget: Text('+by company tarrifs',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold),))


      ],),),
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
