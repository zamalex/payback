import 'package:flutter/material.dart';
import 'package:payback/colors.dart';
import 'package:payback/custom_widgets.dart';

class CommitmentsScreen extends StatelessWidget {
  const CommitmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My commitmetns',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: kBlueLightColor,
                borderRadius: BorderRadius.circular(15)
              ),
              padding: EdgeInsets.all(8),
              child: Column(children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                  visualDensity: VisualDensity( vertical: -4),
                  title: Text('Unassigned cashback, SAR',style: TextStyle(fontSize: 15),),trailing:Text('20 SAR',style: TextStyle(fontSize: 20,color: kBlueColor,fontWeight: FontWeight.bold),) ,)
                ,SizedBox(height: 3,),
        Divider()

       // ,SizedBox(height: 3,),
              ,  ListTile( dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                  visualDensity: VisualDensity( vertical: -4),title: Text('Unassigned cashback, SAR',style: TextStyle(fontSize: 15),),trailing:Text('20 SAR',style: TextStyle(fontSize: 20,color: kBlueColor,fontWeight: FontWeight.bold),) ,)

               // ,SizedBox(height: 3,),
              ,  Divider()

               // ,SizedBox(height: 3,),
               , ListTile( dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                  visualDensity: VisualDensity( vertical: -4),title: Text('Unassigned cashback, SAR',style: TextStyle(fontSize: 15),),trailing:Text('20 SAR',style: TextStyle(fontSize: 20,color: kBlueColor,fontWeight: FontWeight.bold),) ,)


              ],),
            ),
            Expanded(child: ListView.builder(itemBuilder: (c,i){
              return Container(margin:EdgeInsets.symmetric(vertical: 4),child: Commitment());
            },itemCount: 5,),),

            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                child: CustomButton(buttonText: '+ Add new commitment', buttonColor:Colors.red))
          ],
        ),
      ),
    );
  }
}
