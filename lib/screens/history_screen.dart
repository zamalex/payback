import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../providers/CommitmentsProvider.dart';
import 'main.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonIcon(),
        actions: [
          InkWell(
              onTap: (){
                showCustomDateRangePicker(context, dismissible: true, minimumDate:DateTime(1990,), maximumDate: DateTime.now(), onApplyClick: (one,two){}, onCancelClick: (){}, backgroundColor: Colors.white, primaryColor: kBlueColor);
              },
              child: Container(child: Icon(Icons.calendar_month,color: kBlueColor,),margin: EdgeInsets.only(right:16),))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text('Cashback dashboard',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),
              SizedBox(height: 20,),
              SlideSwitcher(
                containerColor: Colors.white,
                slidersColors: const [
                  kBlueColor,
                ],
                containerBorder: Border.all(color: Colors.white, width: 5),
                children: [
                  Text(
                    'Spent',
                    style: TextStyle(color: selected == 0 ? Colors.white : kBlueColor),
                  ),
                  Text(
                    'Received',
                    style: TextStyle(color: selected == 1 ? Colors.white : kBlueColor),
                  ),
                ],
                onSelect: (index) {
                  setState(() {
                    selected = index;
                  });
                },
                containerHeight: 45,
                containerWight: MediaQuery.of(context).size.width-32-10,
              ),
              SizedBox(height: 20,),
              Consumer<CommitmentsProvider>(builder:(context, value, child) =>  SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: List.generate(months.length, (index) => MonthWidget(name: months[index],isChecked: value.selectedMonth==months[index],)),),)),
              SizedBox(height: 20,),
              Row(children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  //width: MediaQuery.of(context).size.width/2,
                  radius: MediaQuery.of(context).size.width*.25,
                  child: PieChart(

                  data: const [
                    PieChartData(Color(0xFF8B3FB9), 25),
                    PieChartData(Color(0xFF6E4CB6), 50),
                    PieChartData(Color(0xFF6274D1), 12),
                    PieChartData(Color(0xFF34C1B9), 13),
                  ],
                  radius: (MediaQuery.of(context).size.width*.25)-22,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.purple),
                        child: Text(
                          '50%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 4,),
                      Container(child: Text('Travel and vacation',style:TextStyle(color: Colors.purple,fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),width: 70,),
                    ],
                  ),
                ),),
                SizedBox(width: 20,),
                Expanded(child: Column(children: [
                  Container(
                    decoration:BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20),topRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                    padding: EdgeInsets.all(16),child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('Total cashback spent (SAR):')
                    ,Text('2500',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ],),),
  SizedBox(height: 10,)

                  ,Container(
                    decoration:BoxDecoration(color: Colors.purple.shade50,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20),topRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                    padding: EdgeInsets.all(16),child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('Total cashback spent (SAR):',style: TextStyle(color:Colors.purple),)
                    ,Text('2500',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple),),
                  ],),)
                ],))
              ],),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(child: Text('Source',style: TextStyle(fontWeight: FontWeight.bold),)),
                    Container(margin:EdgeInsets.only(right: 50,left: 10),child: Text('% from all',style: TextStyle(fontWeight: FontWeight.bold),)),
                    Container(child: Text('Spent',style: TextStyle(fontWeight: FontWeight.bold),)),

                  ],
                ),
              ),
              Column(children: List.generate(4, (index) => Container(child:  Row(
                children: [
                  Expanded(child: Row(children: [Icon(Icons.airplanemode_active), SizedBox(width: 5,),Text('Travel and vacation',style: TextStyle(fontWeight: FontWeight.normal),)],)),
                  Container(margin:EdgeInsets.only(right: 50,left: 10),child: Text('10%',style: TextStyle(fontWeight: FontWeight.normal),)),
                  Container(child: Text('20%',style: TextStyle(fontWeight: FontWeight.normal),)),

                ],
              ),padding:EdgeInsets.all(12),margin: EdgeInsets.only(bottom: 4),decoration: BoxDecoration(borderRadius:BorderRadius.circular(12),color: Colors.grey.shade200),)),)

          ],),
        ),
      ),
    );
  }
}

class MonthWidget extends StatelessWidget {
   MonthWidget({super.key,required this.name,required this.isChecked});

   bool isChecked = false;
   
   
   String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<CommitmentsProvider>(context,listen: false).selectMonth(name);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: isChecked?kPurpleColor:kPurpleColor.withOpacity(.1)),
        child: Text(name,style: TextStyle(color: isChecked?Colors.white:kPurpleColor),),
      ),
    );
  }
}

