import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/functions.dart';
import 'package:payback/model/orders_model.dart';
import 'package:payback/providers/checkout_provider.dart';
import 'package:payback/screens/order_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../helpers/colors.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) => getOrders());
  }

  getOrders() {
    Provider.of<CheckoutProvider>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leadingWidth: 100,
        leading: TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kPurpleColor,
            ),
            label: Text(
              'Back',
              style: TextStyle(color: kPurpleColor),
            )),
      ),
      body: Consumer<CheckoutProvider>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.all(8),
          child: Column(children: [
            SlideSwitcher(
              containerColor: Colors.white,
              slidersColors: const [
                kBlueColor,
              ],
              containerBorder: Border.all(color: Colors.white, width: 5),
              children: [
                Text(
                  'Completed',
                  style: TextStyle(
                      color: selected == 0 ? Colors.white : kBlueColor),
                ),
                Text(
                  'In progress',
                  style: TextStyle(
                      color: selected == 1 ? Colors.white : kBlueColor),
                ),
                Text(
                  'Cancelled',
                  style: TextStyle(
                      color: selected == 2 ? Colors.white : kBlueColor),
                ),
              ],
              onSelect: (index) {
                setState(() {
                  selected = index;
                  value.selectedStatus = selected==0?'completed':selected==1?'pending':'cancelled';
                  value.loadOrders();
                });
              },
              containerHeight: 45,
              containerWight: MediaQuery.of(context).size.width - 32 - 10,
            ),
            SizedBox(
              height: 20,
            ),
           value.isLoading?Center(child: CircularProgressIndicator(),): Expanded(
                child: SingleChildScrollView(
                  child: Column(
                                children: List.generate(
                    value.orders.length,
                    (index) => MyOrderItem(
                          order: value.orders[index],
                        )),
                              ),
                ))
          ]),
        ),
      ),
    );
  }
}

class MyOrderItem extends StatelessWidget {
  MyOrderItem({super.key, required this.order});

  Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(OrderDetails(order: order,));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyOrderSubItem(order: order,),
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 10),
              child: Text(
                'Order №${order.id??''}',
                maxLines: 1,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Time & date'), Text(parseDate(order.dateTime!))],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Total price'), Text('${order.totalPrice??0} SAR')],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Cashback'), Text('0 SAR')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyOrderSubItem extends StatelessWidget {
   MyOrderSubItem({super.key,required this.order});

  Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: kWhitrColor),
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
                  child: CachedNetworkImage(imageUrl: order.productImage??'',width: 60,
                    height: 60,
                    fit: BoxFit.cover,errorWidget: (context, url, error) =>Image.network('https://www.huber-online.com/daisy_website_files/_processed_/8/0/csm_no-image_d5c4ab1322.jpg',width: 60,
                        height: 60,
                        fit: BoxFit.cover),)/*Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuCxMPJwglskH6j6jQhCmJGqIr9kR6_iMPng&usqp=CAU',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )*/),
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
                            child: Text('${order.vendorName}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.grey)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${order.productName}',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
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
