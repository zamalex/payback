import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/helpers/functions.dart';
import 'package:payback/model/auth_response.dart';
import 'package:payback/providers/checkout_provider.dart';
import 'package:payback/screens/cart_screen.dart';
import 'package:payback/screens/checkout_object.dart';
import 'package:payback/screens/main_screen.dart';
import 'package:payback/screens/payment_success_screen.dart';
import 'package:provider/provider.dart';

import '../data/service_locator.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  User? user = sl<AuthResponse>().data!.user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(user!=null){
      nameController.text = user!.name??'';
      phoneController.text = user!.phone??'';

    }
    Future.delayed(Duration.zero).then((value) {
      getShippings();
    });
  }

  String receiverName = '';
  String receiverPhone = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  getShippings() {
    Provider.of<CheckoutProvider>(context, listen: false).getShippingMethods();
  }

  submitOrder() {
    Map<String, dynamic> request = {};
    List<Map<String, dynamic>> ordersArray = [];

    bool allowed = true;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    request.putIfAbsent('receiver_name', () => receiverName);
    request.putIfAbsent('receiver_phone', () => receiverPhone);

    List<CheckoutObject> ordersList =
        Provider.of<CheckoutProvider>(context, listen: false).checkouts;
    CheckoutProvider provider =
        Provider.of<CheckoutProvider>(context, listen: false);

    ordersList.forEach((order) {
      if (order.selectedPickup == 0) {
        if (!order.selfFormKey.currentState!.validate()) {
          allowed = false;
        }
      } else {
        if (!order.courierFormKey.currentState!.validate()) {
          allowed = false;
        }
      }
    });

    if (allowed) {
      ordersList.forEach((order) {
        Map<String, dynamic> map = {};

        map.putIfAbsent(
            'vendor_id', () => order.vendor);

         map.putIfAbsent(
            'delivery_method_id', () => provider.shippings[order.selectedDelivery].id);

        map.putIfAbsent(
            'payment_setting_id', () => 1);

        map.putIfAbsent(
            'product_options', () => null);

        map.putIfAbsent(
            'status', () => 'pending');

        map.putIfAbsent(
            'tax_amount', () => 0);

        map.putIfAbsent(
            'shipping_amount', () => 0);

        map.putIfAbsent(
            'discount_amount', () => 0);
        
        map.putIfAbsent(
            'sub_total', () => order.getTotalPrice());


        map.putIfAbsent(
            'amount', () => order.getTotalPrice());

        map.putIfAbsent(
            'coupon_code', () => null);

        map.putIfAbsent('description', () => order.comments);


        if (order.selectedPickup == 0) {
          order.selfFormKey.currentState!.save();
          map.putIfAbsent('pickup', () => 'self');
          map.putIfAbsent('office_address', () => order.officeAddress);

        } else {
          order.courierFormKey.currentState!.save();

          map.putIfAbsent('pickup', () => 'courier');
          map.putIfAbsent('city', () => order.city);
          map.putIfAbsent('street', () => order.street);
          map.putIfAbsent('building', () => order.building);
          map.putIfAbsent('apartment', () => order.apartment);

        }

        map.putIfAbsent('items', () => order.getItems());




        ordersArray.add(map);
      });
      request.putIfAbsent('orders', () => ordersArray);

      print('request:${jsonEncode(request).toString()}');



      provider.createOrder(request).then((value){
        Get.snackbar(value['data']?'Success':'Failed',value['message'],colorText: Colors.white,backgroundColor: value['data']?Colors.green:Colors.red);

        if(value['data']){
          Get.to(PaymentSuccessScreen(data: value,));
        }

      });

    } else {
      Get.snackbar('Alert', 'You must fill all required data to proceed',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:Provider.of<CheckoutProvider>(context).checkouts.isEmpty?null: AppBar(
          backgroundColor: kBackgroundColor,
          centerTitle: true,
          title: Text('Checkout'),
          leading: Center(
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: kPurpleColor),
                )),
          ),
        ),
        body: Consumer<CheckoutProvider>(
          builder: (context, value, child) {

            if(value.checkouts.isEmpty){

              return MainScreen();
              //Get.to(MainScreen(index: 1,));
            }

            double allTotal = 0;
            value.checkouts.forEach((element) {
              allTotal+= element.getTotalPrice();
            });

            return SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                Text(
                                  'Attention!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.orange),
                                ),
                                Text(
                                  'Products that are at different warehouses or from different sellers would be delivered as a separate orders!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Receiver name'),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            controller: nameController,
                            hintText: 'Receiver name or pre-filled',
                            onSaved: (s) {
                              receiverName = s;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Receiver phone number'),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            controller: phoneController,
                            hintText: 'Receiver phone number or pre-filled',
                            onSaved: (s) {
                              receiverPhone = s;
                            },
                            type: TextInputType.phone,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: List.generate(
                                value.checkouts.length,
                                (index) => CheckoutItem(
                                      //checkoutObject: value.checkouts[index],
                                      orderIndex: index,
                                    )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: kBlueLightColor.withOpacity(.7)),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total orders price'),
                                    Text(
                                      '${allTotal} SAR',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Delivery'),
                                    Text(
                                      '0 SAR',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total orders cashack'),
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
                            height: 20,
                          )
                        ],
                      )),
                    )),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      child:value.isLoading?Center(child: CircularProgressIndicator(),): Container(
                          width: double.infinity,
                          child: CustomButton(
                            buttonText: 'Submit order',
                            buttonColor: kPurpleColor,
                            onTap: () {
                              submitOrder();
                            },
                          )),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class CheckoutItem extends StatefulWidget {
  CheckoutItem(
      {super.key, required this.orderIndex});

 late CheckoutObject checkoutObject;
  int orderIndex;

  @override
  State<CheckoutItem> createState() => _CheckoutItemState();
}

class _CheckoutItemState extends State<CheckoutItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController streetTextEditingController = TextEditingController();
  TextEditingController buildingTextEditingController = TextEditingController();
  TextEditingController apartmentTextEditingController = TextEditingController();
  TextEditingController commentsTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   widget.checkoutObject =Provider.of<CheckoutProvider>(context,listen: false).checkouts[widget.orderIndex];

    return Consumer<CheckoutProvider>(
      builder:(context, pp, child) {
        addressTextEditingController.text= addressTextEditingController.text;
        cityTextEditingController.text= cityTextEditingController.text;
        streetTextEditingController.text= streetTextEditingController.text;
        buildingTextEditingController.text= buildingTextEditingController.text;
        apartmentTextEditingController.text= apartmentTextEditingController.text;
        commentsTextEditingController.text= commentsTextEditingController.text;

        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ${widget.orderIndex + 1}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: List.generate(
                widget.checkoutObject.products.length,
                    (index) => CartItem(product: widget.checkoutObject.products[index]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Delivery method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      Provider.of<CheckoutProvider>(context).shippings.length,
                          (index) => DeliveryMethod(
                          myIndex: index,
                          selectedIndex: widget.checkoutObject.selectedDelivery,
                          txt:Provider.of<CheckoutProvider>(context).shippings.isNotEmpty? Provider.of<CheckoutProvider>(context)
                              .shippings[index]
                              .name ??'':''
                              '',
                          img: Provider.of<CheckoutProvider>(context)
                              .shippings[index]
                              .logo ??
                              '',
                          onTap: () {
                            Provider.of<CheckoutProvider>(context, listen: false)
                                .updateDelivery(widget.orderIndex, index);
                          })),
                )),
            SizedBox(
              height: 15,
            ),
            Text(
              'Pick up',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Radio(
                    value: 0,
                    groupValue: widget.checkoutObject.selectedPickup,
                    onChanged: (value) {
                      Provider.of<CheckoutProvider>(context, listen: false)
                          .updatePickup(widget.orderIndex, value!!);
                    },
                    activeColor: kBlueColor),
                Text('Self pick up'),
                Radio(
                    value: 1,
                    groupValue: widget.checkoutObject.selectedPickup,
                    onChanged: (value) {
                      Provider.of<CheckoutProvider>(context, listen: false)
                          .updatePickup(widget.orderIndex, value!!);
                    },
                    activeColor: kBlueColor),
                Text('Courier'),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            widget.checkoutObject.selectedPickup == 0
                ? Form(
              key: widget.checkoutObject.selfFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose delivery office'),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: addressTextEditingController,
                    onChanged: (s){

                    },
                    hintText: 'Office address',
                    onSaved: (s) {
                      Provider.of<CheckoutProvider>(context, listen: false)
                          .checkouts[widget.orderIndex]
                          .officeAddress = s;
                    },
                  ),
                ],
              ),
            )
                : Form(
              key: widget.checkoutObject.courierFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('City'),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: cityTextEditingController,
                    hintText: 'Choose your city',
                    onSaved: (s) {
                      Provider.of<CheckoutProvider>(context, listen: false)
                          .checkouts[widget.orderIndex]
                          .city = s;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Street'),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: streetTextEditingController,
                      hintText: 'Choose your street',
                      onSaved: (s) {
                        Provider.of<CheckoutProvider>(context, listen: false)
                            .checkouts[widget.orderIndex]
                            .street = s;
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Building'),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                controller: buildingTextEditingController,
                                  hintText: 'Building N',
                                  onSaved: (s) {
                                    Provider.of<CheckoutProvider>(context,
                                        listen: false)
                                        .checkouts[widget.orderIndex]
                                        .building = s;
                                  })
                            ],
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Apartment'),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                controller: apartmentTextEditingController,
                                  hintText: 'Apartment N',
                                  onSaved: (s) {
                                    Provider.of<CheckoutProvider>(context,
                                        listen: false)
                                        .checkouts[widget.orderIndex]
                                        .apartment = s;
                                  })
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Comments for courier'),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: commentsTextEditingController,
                    hintText:
                    'Enter additional info. Any door passwords, elevator availability etc.',
                    onSaved: (s) {
                      Provider.of<CheckoutProvider>(context, listen: false)
                          .checkouts[widget.orderIndex]
                          .comments = s;
                    },
                    maxLines: 3,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Order ${widget.orderIndex + 1} summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: kBlueLightColor.withOpacity(.7)),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price'),
                      Text(
                        '${widget.checkoutObject.getTotalPrice()} SAR',
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
                      Text('Delivery'),
                      Text(
                        Provider.of<CheckoutProvider>(context).shippings.isNotEmpty?Provider.of<CheckoutProvider>(context).shippings[widget.checkoutObject.selectedDelivery].name??'':'',
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
              height: 20,
            ),
          ],
        );
      },
    );
  }
}

class DeliveryMethod extends StatelessWidget {
  DeliveryMethod(
      {super.key,
      required this.img,
      required this.myIndex,
      required this.selectedIndex,
      required this.txt,
      required this.onTap});
  Function onTap;
  int myIndex;
  int selectedIndex;
  String txt;
  String img;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 120,
        height: 80,
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Image.network(
                      img,
                      width: 60,
                      height: 20,
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          txt,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: myIndex == selectedIndex
                                  ? kBlueColor
                                  : Colors.grey,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 1,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: myIndex == selectedIndex ? kBlueColor : Colors.grey,
                width: 1)),
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
