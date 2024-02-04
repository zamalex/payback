import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/providers/checkout_provider.dart';
import 'package:payback/screens/cart_screen.dart';
import 'package:payback/screens/checkout_object.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Close',style: TextStyle(color: kPurpleColor),),
      ),),
      body: SafeArea(child: Column(
        children: [Expanded(child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(child: Column(

            crossAxisAlignment:CrossAxisAlignment.start,children: [

            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Attention!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.orange),),
                  Text('Products that are at different warehouses or from different sellers would be delivered as a separate orders!',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14,color: Colors.orange),),

                ],
              ),
            ),
            SizedBox(height: 20,),

            Text('Receiver name'),
            SizedBox(height: 5,),
            CustomTextField(hintText: 'Receiver name or pre-filled')

            ,SizedBox(height: 15,),

            Text('Receiver phone number'),
            SizedBox(height: 5,),
            CustomTextField(hintText: 'Receiver phone number or pre-filled'),
            SizedBox(height: 20,),
            Consumer<CheckoutProvider>(
              builder:(context, value, child) => Column(
                children: List.generate(2, (index) => CheckoutItem(checkoutObject: value.checkouts[index],orderIndex: index,)),
              ),
            ),
            SizedBox(height: 15,),
            Text('Total',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),color: kBlueLightColor.withOpacity(.7)),
              padding: EdgeInsets.all(16),
              child: Column(children: [
                Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text('Total orders price'),Text('20,000 SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold,fontSize: 18),)],)
                ,SizedBox(height: 15,),
                Divider()
                ,SizedBox(height: 15,),
                Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text('Delivery'),Text('20,000 SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold,fontSize: 18),)],)
                ,SizedBox(height: 15,),
                Divider()
                ,SizedBox(height: 15,),
                Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text('Total orders cashack'),Text('20,000 SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold,fontSize: 18),)],)
              ],),
            ),
            SizedBox(height: 20,)

          ],)),
        )),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),
            child: Container(
                width:double.infinity,child: CustomButton(buttonText: 'Submit order', buttonColor: kPurpleColor)),
          )
        ],
      ),)
    );
  }
}

class CheckoutItem extends StatelessWidget {
   CheckoutItem({super.key,required this.checkoutObject,required this.orderIndex});

  CheckoutObject checkoutObject;
  int orderIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order ${orderIndex+1}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        CartItem(),
        SizedBox(height: 15,),
        Text('Delivery method',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

        SizedBox(height: 15,),

        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: List.generate(4, (index) => DeliveryMethod(myIndex: index, selectedIndex: checkoutObject.selectedDelivery, txt: 'Method ${index+1}', onTap: (){
              Provider.of<CheckoutProvider>(context,listen: false).updateDelivery(orderIndex, index);
            })),)),

        SizedBox(height: 15,),
        Text('Pick up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Row(
          children: [
            Radio(value: 0, groupValue: checkoutObject.selectedPickup, onChanged: (value) {
              Provider.of<CheckoutProvider>(context,listen: false).updatePickup(orderIndex, value!!);

            },activeColor: kBlueColor),
            Text('Self pick up'),
            Radio(value: 1, groupValue: checkoutObject.selectedPickup, onChanged: (value) {
              Provider.of<CheckoutProvider>(context,listen: false).updatePickup(orderIndex, value!!);

            },activeColor: kBlueColor),
            Text('Courier'),
    SizedBox(height: 10,),


          ],
        ),
        SizedBox(height: 10,),

        checkoutObject.selectedPickup==0?
        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text('Choose delivery office'),
          SizedBox(height: 5,),
          CustomTextField(hintText: 'Office address'),],):
            Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              Text('City'),
              SizedBox(height: 5,),
              CustomTextField(hintText: 'Choose your city'),
              SizedBox(height: 10,),
              Text('Street'),
              SizedBox(height: 5,),
              CustomTextField(hintText: 'Choose your street')
              ,SizedBox(height: 10,),

              Row(children: [
                Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('Building'),
                  SizedBox(height: 5,),
                  CustomTextField(hintText: 'Building N')],)),
                SizedBox(width: 15,),
                Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('Apartment'),
                  SizedBox(height: 5,),
                  CustomTextField(hintText: 'Apartment N')],))
              ],),
              SizedBox(height: 10,),
              Text('Comments for courier'),
              SizedBox(height: 5,),
              CustomTextField(hintText: 'Enter additional info. Any door passwords, elevator availability etc.',maxLines: 3,)


            ],),

        SizedBox(height: 20,),
        Text('Order ${orderIndex+1} summary',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),color: kBlueLightColor.withOpacity(.7)),
          padding: EdgeInsets.all(16),
          child: Column(children: [
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text('Price'),Text('20,000 SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold,fontSize: 18),)],)
            ,SizedBox(height: 15,),
            Divider()
            ,SizedBox(height: 15,),
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text('Delivery'),Text('by company tarrifs',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold,fontSize: 18),)],)
                    ,SizedBox(height: 15,),

        Divider()
            ,SizedBox(height: 15,),
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text('Cashback'),Text('20,000 SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold,fontSize: 18),)],)
          ],),
        ),
        SizedBox(height: 20,),

      ],
    );

  }
}


class DeliveryMethod extends StatelessWidget {
  DeliveryMethod({super.key, required this.myIndex,required this.selectedIndex,required this.txt,required this.onTap});
  Function onTap;
  int myIndex;
  int selectedIndex;
  String txt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 120,
        height: 80,
        child: Stack(
          children: [
            Center(
              child:Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPdRZh8TJiJxxdkvyg61IBHGiVQgQZhm62YXJb_YPeRQ&s',width: 60,height: 20,),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(txt,textAlign: TextAlign.center,style: TextStyle(color: myIndex==selectedIndex?kBlueColor:Colors.grey),))
                  ],
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16),border: Border.all(color: myIndex==selectedIndex?kBlueColor:Colors.grey,width: 1)),
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
