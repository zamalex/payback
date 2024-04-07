import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/data/http/urls.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/helpers/functions.dart';
import 'package:payback/model/auth_response.dart';
import 'package:payback/providers/checkout_provider.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/checkout_screen.dart';
import 'package:provider/provider.dart';

import '../data/service_locator.dart';
import '../model/product_model.dart';
import 'main_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key,required this.selectNav});

  Function selectNav;


  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


      Future.delayed(Duration.zero).then((value){
        Provider.of<HomeProvider>(context,listen: false).selectedHomeIndex=-1;
        Provider.of<HomeProvider>(context,listen: false).getProducts().then((value){
          Provider.of<CheckoutProvider>(context,listen: false).readCart(Provider.of<HomeProvider>(context,listen: false).products,null);




        });
      });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<CheckoutProvider>(
          builder:(c,provider,cc){
            double total=0;
      
            provider.cart.forEach((element) {
              total = total+(element.cartQuantity*double.parse(element.price??'0'));
            });
      
            if(provider.cart.isEmpty){
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,children: [
                Icon(Icons.remove_shopping_cart,size: 50,color: kBlueColor,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Cart is empty',style: TextStyle(color: kBlueColor),),
                    SizedBox(width: 10,),
                    InkWell(
                        onTap: (){
                          widget.selectNav();
                        },
                        child: Text('Go Home',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),)),
                  ],
                )
              ],),);

            }
            
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'My cart',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You will cover 12% of your commitments',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'by purchasing products that are in cart now',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(10, 91, 148, 1),
                            Color.fromRGBO(45, 133, 194, 1),
                          ]),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: List.generate(provider.cart.length, (index) => CartItem(product: provider.cart[index],)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Summary',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: kBlueLightColor),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total price'),
                              Text(
                                '${total.toStringAsFixed(2)} SAR',
                                style: TextStyle(
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cashback'),
                              Text(
                                '0 SAR',
                                style: TextStyle(
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Visibility(child: Container(
                      child: CustomButton(
                          buttonText: 'Proceed to check out',
                          buttonColor: kPurpleColor,
                          onTap: () {
                            if(!sl.isRegistered<AuthResponse>()){

                              showGoToLogin();
                              return;
                            }

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckoutScreen(),));
                            //Get.to(CheckoutScreen());
                          }),
                      width: double.infinity,
                    ),visible: provider.cart.isNotEmpty,)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
   CartItem({super.key,this.product});
  Product? product;
  @override
  Widget build(BuildContext context) {
    if(product==null){
      product = jsonDecode(Url.PRODUCT_JSON);
      product!.cartQuantity=12;
    }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: kWhitrColor),
      margin: EdgeInsets.only(bottom: 8),
      width: double.infinity, //MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Card(
          elevation: 0,
          color: kWhitrColor,
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(imageUrl: product!.featuredImage??'',width: 120,
                    height: 120,
                    fit: BoxFit.cover,errorWidget:(context, url, error) => Image.asset(
                       'assets/images/payback_logo.png',
                        width: 120,
                        height: 120,
                        color: kBlueColor,
                        fit: BoxFit.contain,
                      ) ,)),
              /*
              * Image.network(
                    product!.featuredImage??'',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
              * */
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(product!.name??'',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.grey)),
                          ),
                          InkWell(
                            onTap: (){
                              Provider.of<CheckoutProvider>(context,listen: false).removeFromCart(product!,remove: true);

                            },
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product!.description??'',
                             // maxLines: 1,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  //overflow: TextOverflow.ellipsis,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap:(){
                              Provider.of<CheckoutProvider>(context,listen: false).removeFromCart(product!);

                            },
                            child: CircleAvatar(
                              child: Icon(
                                Icons.remove,
                                size: 25,
                              ),
                              radius: 16,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('${product!.cartQuantity}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: (){
                              Provider.of<CheckoutProvider>(context,listen: false).addToCart(product!);

                            },
                            child: CircleAvatar(
                              child: Icon(
                                Icons.add,
                                size: 25,
                              ),
                              radius: 16,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              '${product!.price} SAR ',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kPurpleColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
