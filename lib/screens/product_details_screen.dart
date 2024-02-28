import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/model/product_model.dart';
import 'package:payback/providers/checkout_provider.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';
import '../data/service_locator.dart';
import '../helpers/custom_widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({Key? key,required this.product}) : super(key: key);

  Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) =>  Provider.of<HomeProvider>(context,listen: false
    ).getVendors());
  }


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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: kBlueLightColor,image:DecorationImage(image: NetworkImage(widget.product.featuredImage??'',),fit: BoxFit.cover)),
                  ),
                  Container(height: 20),

                  Consumer<HomeProvider>(builder:(context, value, child) =>Text(value.getPartnerNameByID(widget.product.vendor_id??0),style: TextStyle(fontSize: 15),)),

                  Text(widget.product.name??'',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Container(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${widget.product.price} SAR',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: kPurpleColor),),
                      Container(

                        child: Text('Cashback: 12,9 SAR',style: TextStyle(fontSize:11,color: kPurpleColor,),),
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),

                        decoration:BoxDecoration(color: kPurpleColor.withOpacity(.32),borderRadius: BorderRadius.circular(10)),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(widget.product.description??'',style: TextStyle(fontSize: 15),),

                  SizedBox(height: 10,),
                  Card(
                    elevation: 1,
                    color: Colors.white,
                     child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          ProductListTile(title: 'Product information',image: 'assets/images/product_characteristics.png',),
                          Divider(), ProductListTile(title: 'Delivery and pickup',image: 'assets/images/shipping_info.png',),
                          Divider(), ProductListTile(title: 'Support',image: 'assets/images/support_icon.png',),
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
              width:double.infinity,child: CustomButton(buttonText: 'Add to cart', buttonColor: kPurpleColor,onTap: (){
                Provider.of<CheckoutProvider>(context,listen: false).addToCart(widget.product);
                Get.snackbar('Success', 'Item added to cart',backgroundColor: Colors.green,colorText: Colors.white);
          },)),
        )
      ],
    ),);
  }
}

class ProductListTile extends StatelessWidget {
   ProductListTile({super.key,required this.title,required this.image});
  String title;
  String image;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(image,width: 16,height: 16,),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios,color: kBlueColor,),
      ),
    );
  }
}
