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


  double calculateSpent(bool spent,List<HistoryCategory> cats){
    double all = 0;
    cats.forEach((element) {

      spent?all+= element.summary!.spent!:all+= element.summary!.received!;
    });

    return all;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) => getCashbackHistory());
  }

  getCashbackHistory(){
    selectedCategory = null;
    selectedColorIndex = -1;
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
        builder:(context, value, child) => Container(
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

getCashbackHistory();


                  },
                  containerHeight: 45,
                  containerWight: MediaQuery.of(context).size.width-32-10,
                ),
                SizedBox(height: 20,),
                value.isLoading?Center(child: CircularProgressIndicator(),):value.cashbackHistory==null?Center(child: Text('No available data',)): Column(children: [
                  SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: List.generate(value.months.length, (index) => MonthWidget(name: value.months[index],isChecked: value.selectedMonth==value.months[index],onTap: (mon){
                    getCashbackHistory();
                  },)),),),
                  SizedBox(height: 20,),

                  Row(children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    //width: MediaQuery.of(context).size.width/2,
                    radius: MediaQuery.of(context).size.width*.25,
                    child:PieChartSample2(spent:selected==0,categories: value.cashbackHistory!.categories!,onTap: (ss){

                        setState(() {

                          if(ss!=-1)
                          selectedCategory = value.cashbackHistory!.categories![ss];
                          selectedColorIndex = ss;
                        });
                    },) ,
                  ),
                  SizedBox(width: 20,),
                  Expanded(child: Column(children: [
                    Container(
                      decoration:BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20),topRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                      padding: EdgeInsets.all(16),child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('Total cashback spent (SAR):')
                      ,Text('${calculateSpent(selected==0, value.cashbackHistory!.categories!)}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ],),),
                    SizedBox(height: 10,)

                    ,(selectedCategory==null||selectedColorIndex==-1)?Container():Container(
                      decoration:BoxDecoration(color: colors[selectedColorIndex%colors.length].withOpacity(.2),borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20),topRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                      padding: EdgeInsets.all(16),child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('Spent on ${selectedCategory!.category}:',style: TextStyle(color:colors[selectedColorIndex%colors.length]),)
                      ,Text('${selected==0?selectedCategory!.summary!.spent:selectedCategory!.summary!.received}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: colors[selectedColorIndex%colors.length]),),
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
                Column(children: List.generate(value.cashbackHistory!.categories!.length, (index) => InkWell(
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
                      Expanded(child: Row(children: [Icon(Icons.airplanemode_active), SizedBox(width: 5,),Text(value.cashbackHistory!.categories![index].category??'',style: TextStyle(fontWeight: FontWeight.normal),)],)),
                      Container(margin:EdgeInsets.only(right: 50,left: 10),child: Text('${selected==0?value.cashbackHistory!.categories![index].summary!.fromAllSpent:value.cashbackHistory!.categories![index].summary!.fromAllReceived}%',style: TextStyle(fontWeight: FontWeight.normal),)),
                      Container(child: Text('${value.cashbackHistory!.categories![index].summary!.spent}',style: TextStyle(fontWeight: FontWeight.normal),)),

                    ],
                  ),padding:EdgeInsets.all(12),margin: EdgeInsets.only(bottom: 4),decoration: BoxDecoration(borderRadius:BorderRadius.circular(12),color: Colors.grey.shade200),),
                )),)

              ],)
            ],),
          ),
      ),
      ),
    );
  }
}

class MonthWidget extends StatelessWidget {
   MonthWidget({super.key,this.onTap,required this.name,required this.isChecked});

   bool isChecked = false;

   Function? onTap;
   
   
   String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<CommitmentsProvider>(context,listen: false).selectMonth(name);
        if(onTap!=null){
          onTap!(name);
        }
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

