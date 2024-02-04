import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                'My cart',
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
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
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    'by purchasing products that are in cart now',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white),
                  ),
                ],),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color.fromRGBO(10, 91, 148, 1),Color.fromRGBO(45, 133, 194, 1),]),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20),topLeft: Radius.circular(5),bottomRight: Radius.circular(5))
                ),
              ),
              SizedBox(height: 20,),
              Column(children: List.generate(2, (index) => CartItem()),),
              SizedBox(height: 20,),
              Text('Summary',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),color: kBlueLightColor.withOpacity(.7)),
                padding: EdgeInsets.all(16),
              child: Column(children: [
                Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text('Total price'),Text('20,000 SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold,fontSize: 18),)],)
                ,SizedBox(height: 15,),
                Divider()
              ,SizedBox(height: 15,),
                Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text('Cashback'),Text('20,000 SAR',style: TextStyle(color:kBlueColor,fontWeight: FontWeight.bold,fontSize: 18),)],)
              ],),
              ),

              SizedBox(height: 25,),
              Container(child: CustomButton(buttonText: 'Proceed to check out', buttonColor: kPurpleColor),width: double.infinity,)

            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: kWhitrColor),
      margin: EdgeInsets.only(bottom: 8),
      width: double.infinity,//MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Card(
          elevation: 0,
          color: kWhitrColor,
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuCxMPJwglskH6j6jQhCmJGqIr9kR6_iMPng&usqp=CAU',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )),
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
                            child: Text('Sneakers shoes woman ',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.grey)),
                          ),
                          Icon(
                            Icons.delete_outline,
                            color: Colors.red,
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
                              'Sneakers shoes woman',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
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
                          CircleAvatar(

                            child: Icon(Icons.remove,size: 30,),
                            radius: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('1'),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            child: Icon(Icons.add,size: 30,),
                            radius: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(

                              '1000 SAR ',
                              textAlign: TextAlign.end,
                              style: TextStyle(

                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
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
