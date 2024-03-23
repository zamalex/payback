import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/model/cashback_dashboard.dart';
import 'package:payback/screens/commitment_category_spent_screen.dart';
import 'package:payback/screens/pie_chart_lib.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../providers/CommitmentsProvider.dart';
import 'commitment_category_received.dart';
import '../main.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  int selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) => getCashbackHistory());
  }

  getCashbackHistory(){
    Provider.of<CommitmentsProvider>(context,listen: false).getCashbackHistory();
  }
HistoryCategory? selectedCategory;
  int selectedColorIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        actions: [
          InkWell(
              onTap: (){
                showCustomDateRangePicker(context, dismissible: true, minimumDate:DateTime(1990,), maximumDate: DateTime.now(), onApplyClick: (one,two){}, onCancelClick: (){}, backgroundColor: Colors.white, primaryColor: kBlueColor);
              },
              child: Container(child: Icon(Icons.calendar_month,color: kBlueColor,),margin: EdgeInsets.only(right:16),))
        ],
      ),
      body: Consumer<CommitmentsProvider>(
        builder:(context, value, child) => value.isLoading?Center(child: CircularProgressIndicator(),):value.cashbackHistory==null?Center(child: Text('No available data',)):Container(
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
              SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: List.generate(value.months.length, (index) => MonthWidget(name: value.months[index],isChecked: value.selectedMonth==value.months[index],)),),),
                SizedBox(height: 20,),
                Row(children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    //width: MediaQuery.of(context).size.width/2,
                    radius: MediaQuery.of(context).size.width*.25,
                    child:PieChartSample2(categories: value.cashbackHistory!.categories,onTap: (ss){
                      setState(() {
                        selectedCategory = value.cashbackHistory!.categories[ss];
                        selectedColorIndex = ss;
                      });
                    },) /*PieChart(
                      data: List.generate(
                        value.cashbackHistory!.categories.length,
                            (index) => PieChartData(
                          colors[index],
                          value.cashbackHistory!.categories[index].fromAll.toDouble(),
                        ),
                      ),
                      radius: (MediaQuery.of(context).size.width * 0.25) - 22,
                      onSectionSelected: (index, data) {
                        double cumulativePercent = 0;
                        for (int i = 0; i < value.cashbackHistory!.categories.length; i++) {
                          cumulativePercent += value.cashbackHistory!.categories[i].fromAll.toDouble();
                          if (index == i) {
                            setState(() {
                              selectedCategory = value.cashbackHistory!.categories[index];
                            });
                            print('Section $index selected. Cumulative Percent: $cumulativePercent');
                            break;
                          }
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.purple,
                            ),
                            child: Text(
                              '50%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(height: 4,),
                          Container(
                            child: Text(
                              'Travel and vacation',
                              style: TextStyle(color: Colors.purple, fontSize: 12),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            width: 70,
                          ),
                        ],
                      ),
                    )*/,
                      ),
                  SizedBox(width: 20,),
                  Expanded(child: Column(children: [
                    Container(
                      decoration:BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20),topRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                      padding: EdgeInsets.all(16),child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('Total cashback spent (SAR):')
                      ,Text('2500',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ],),),
          SizedBox(height: 10,)

                    ,selectedCategory==null?Container():Container(
                      decoration:BoxDecoration(color: Colors.purple.shade50,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20),topRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                      padding: EdgeInsets.all(16),child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('Spent on ${selectedCategory!.name}:',style: TextStyle(color:colors[selectedColorIndex%colors.length]),)
                      ,Text('${selectedCategory!.spent}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: colors[selectedColorIndex%colors.length]),),
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
                Column(children: List.generate(value.cashbackHistory!.categories.length, (index) => InkWell(
                  onTap: (){
                    if(selected==0){
                      Get.to(CommitmentCategorySpentScreen());


                  }
                    else{

                    Get.to(CommitmentCategoryReceivedScreen());
                    }
                  },
                  child: Container(child:  Row(
                    children: [
                      Expanded(child: Row(children: [Icon(Icons.airplanemode_active), SizedBox(width: 5,),Text(value.cashbackHistory!.categories[index].name,style: TextStyle(fontWeight: FontWeight.normal),)],)),
                      Container(margin:EdgeInsets.only(right: 50,left: 10),child: Text('${value.cashbackHistory!.categories[index].fromAll}%',style: TextStyle(fontWeight: FontWeight.normal),)),
                      Container(child: Text('${value.cashbackHistory!.categories[index].spent}',style: TextStyle(fontWeight: FontWeight.normal),)),

                    ],
                  ),padding:EdgeInsets.all(12),margin: EdgeInsets.only(bottom: 4),decoration: BoxDecoration(borderRadius:BorderRadius.circular(12),color: Colors.grey.shade200),),
                )),)

            ],),
          ),
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

