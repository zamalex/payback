import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';

import '../helpers/custom_widgets.dart';



class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  double _counter = 20;
  @override
  Widget build(BuildContext context) {

    return  Container(
      padding: EdgeInsets.all(16),
      child: ListView(children: [
        Row(
          children: [
            Expanded(child: Text('Priority commitments',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
            Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),),
            Icon(Icons.arrow_forward,color: kBlueColor,)
          ],
        ),

        SizedBox(height: 20,),
        Commitment(),
        SizedBox(height: 20,),
        Row(
          children: [
            Expanded(child: Text('Product categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
            Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),),
            Icon(Icons.arrow_forward,color: kBlueColor,)
          ],
        ),
        SizedBox(height: 10,),
        Container(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:5,itemBuilder: (c,i){
            return  Container(margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: kBlueLightColor,
                    child: Icon(Icons.card_giftcard_rounded,color: kBlueColor,size: 35,),
                    radius: 35,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Image 2',
                    style: TextStyle(
                      color: kBlueColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      SizedBox(height: 20,),
        Row(
          children: [
            Expanded(child: Text('Hot deals',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
            Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),),
            Icon(Icons.arrow_forward,color: kBlueColor,)
          ],
        ),
        Text('Best deals from Payback partners that might be interesting to you'),
        SizedBox(height: 10,),
        Container(
          height: 300,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (c,i){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.topCenter,
                        width:170,
                        height:200 ,
                        decoration: BoxDecoration(color: Colors.lightBlueAccent,borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(

                              child: Text('Earn 100 SAR',style: TextStyle(fontSize:11,color: Colors.purple,),),
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),

                              decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),),
                            CircleAvatar(radius:15,child: Icon(Icons.battery_saver_rounded,color: Colors.blue,),backgroundColor: Colors.white,)
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text('Nike shop',style: TextStyle(color: Colors.grey,),overflow: TextOverflow.ellipsis,maxLines: 1,)
                      ,                Text('2000 SAR',style: TextStyle(color: Colors.purple,fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 1)
                      ,                Text('Snakers shoe women',style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 1)

                    ],),
                ),
              );
            },itemCount: 5,),
        ),
        SizedBox(height: 20,),
        Row(
          children: [
            Expanded(child: Text('Suggested for you',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
            Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),),
            Icon(Icons.arrow_forward,color: kBlueColor,)
          ],
        ),
        Text('Check products with best cashback percentage to cover your commitments'),
        SizedBox(height: 10,),
        Container(
          height: 300,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (c,i){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.topCenter,
                        width:170,
                        height:200 ,
                        decoration: BoxDecoration(color: Colors.lightBlueAccent,borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(

                              child: Text('Earn 100 SAR',style: TextStyle(fontSize:11,color: Colors.purple,),),
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),

                              decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),),
                            CircleAvatar(radius:15,child: Icon(Icons.battery_saver_rounded,color: Colors.blue,),backgroundColor: Colors.white,)
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text('Nike shop',style: TextStyle(color: Colors.grey,),overflow: TextOverflow.ellipsis,maxLines: 1,)
                      ,                Text('2000 SAR',style: TextStyle(color: Colors.purple,fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 1)
                      ,                Text('Snakers shoe women',style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 1)

                    ],),
                ),
              );
            },itemCount: 5,),
        )


      ],),
    );
  }
}
