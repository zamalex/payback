import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:slide_switcher/slide_switcher.dart';
import '../helpers/custom_widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(
      title: Text('Product details'),
      leadingWidth: 100,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(child: Icon(Icons.share,color: kBlueColor,),backgroundColor: Colors.white,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(child: Icon(Icons.save,color: kBlueColor,),backgroundColor: Colors.white,),
        )
      ],
      leading: Container(width:100,child: TextButton.icon(onPressed: (){
        Get.back();
      }, icon: Icon(Icons.arrow_back_ios,color: kPurpleColor,), label: Text('Back',style: TextStyle(color: kPurpleColor),),)),
    ),body: Column(
      children: [
        Expanded(

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 224,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: kBlueLightColor,image:DecorationImage(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuCxMPJwglskH6j6jQhCmJGqIr9kR6_iMPng&usqp=CAU',),fit: BoxFit.cover)),
                  ),
                  Container(height: 20),
                  Text('Nike Shop',style: TextStyle(fontSize: 15),),

                  Text('Sneakers nike products',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Container(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2000 SAR',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: kPurpleColor),),
                      Container(

                        child: Text('Cashback: 12,9 SAR',style: TextStyle(fontSize:11,color: kPurpleColor,),),
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),

                        decoration:BoxDecoration(color: kPurpleColor.withOpacity(.32),borderRadius: BorderRadius.circular(10)),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('Sneakers have gone by a variety of names, depending on geography and changing over the decades. The broader category inclusive of sneakers is athletic shoes. The term \'athletic shoes\' is typically used for shoes utilized for jogging or road running and indoor sports such as basketball, but tends to exclude shoes for sports played on grass such as association...',style: TextStyle(fontSize: 15),),

                  SizedBox(height: 10,),
                  Card(
                    elevation: 1,
                    color: Colors.white,
                     child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          ProductListTile(title: 'Product information'),
                          Divider(), ProductListTile(title: 'Delivery and pickup'),
                          Divider(), ProductListTile(title: 'Support'),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),

        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),
          child: Container(
              width:double.infinity,child: CustomButton(buttonText: 'Add to cart', buttonColor: kPurpleColor)),
        )
      ],
    ),);
  }
}

class ProductListTile extends StatelessWidget {
   ProductListTile({super.key,required this.title});
  String title;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: Icon(Icons.delivery_dining),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios,color: kBlueColor,),
      ),
    );
  }
}
