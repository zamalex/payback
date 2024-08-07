import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/data/http/urls.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/model/cashback_dashboard.dart';
import 'package:payback/model/orders_model.dart';
import 'package:payback/screens/commitments_details_another_screen.dart';
import 'package:payback/screens/order_details_screen.dart';
import 'package:provider/provider.dart';

import '../helpers/colors.dart';
import '../providers/CommitmentsProvider.dart';
import 'history_screen.dart';

class CommitmentCategoryReceivedScreen extends StatefulWidget {
   CommitmentCategoryReceivedScreen({super.key,required this.historyCategory});
  HistoryCategory historyCategory;

  @override
  State<CommitmentCategoryReceivedScreen> createState() => _CommitmentCategoryReceivedScreenState();
}

class _CommitmentCategoryReceivedScreenState extends State<CommitmentCategoryReceivedScreen> {

  DateTime? from;
  DateTime? to;


  getCategoryReceivedProducts() {

    if(widget.historyCategory.categoryId!='0'){
      Provider.of<CommitmentsProvider>(context, listen: false)
          .getReceivedProductsOfCategory({
        'category_id':widget.historyCategory.categoryId
        ,'from':from,
        'to':to,
        'month':Provider.of<CommitmentsProvider>(context,listen: false).selectedMonth

      });
    }
    else{
      Provider.of<CommitmentsProvider>(context, listen: false)
          .getContributorsOfReceived({
        'category_id':widget.historyCategory.categoryId,
        'from':from,
        'to':to,
        'month':Provider.of<CommitmentsProvider>(context,listen: false).selectedMonth
      });
    }

    from = null;
    to = null;

  }

  double calculateTotal(){
    double all =0;
    if(widget.historyCategory.categoryId!='0')
    Provider.of<CommitmentsProvider>(context,listen: false).ordersOfCategory.forEach((element) {
      all+=double.parse(element.totalPrice!.toString());
    });

    else
    Provider.of<CommitmentsProvider>(context,listen: false).contributorsOfReceived.forEach((element) {
      all+=double.parse(element.amount!.toString());
    });

    return all;
  }

  getMonthsRange(String name){

    int monthIndex = Provider.of<CommitmentsProvider>(context,listen: false).months.indexOf(name) + 1;

    from = DateTime(DateTime.now().year, monthIndex, 1);
    to = DateTime(DateTime.now().year, monthIndex, 31);
    getCategoryReceivedProducts();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) => getCategoryReceivedProducts());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        actions: [
          InkWell(
              onTap: (){
                showCustomDateRangePicker(context, dismissible: true, minimumDate:DateTime(1990,), maximumDate: DateTime.now(), onApplyClick: (one,two){
                  from= one;
                  to = two;

                  getCategoryReceivedProducts();
                }, onCancelClick: (){
                  from= null;
                  to = null;
                  getCategoryReceivedProducts();

                }, backgroundColor: Colors.white, primaryColor: kBlueColor);
              },
              child: Container(child: Icon(Icons.calendar_month,color: kBlueColor,),margin: EdgeInsets.only(right:16),))
        ],
      ),
      body: Container(padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.historyCategory.category??'',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            SizedBox(height: 20,),
            Consumer<CommitmentsProvider>(builder:(context, value, child) =>   (from != null &&
                to != null &&
                value.selectedMonth.isEmpty)
                ? DataRangeWidget(
              start: from!,
              end: to!,
              reset: () {
                setState(() {
                  from = null;
                  to = null;
                });

                getCategoryReceivedProducts();
              },
            ): SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: List.generate(value.months.length, (index) => MonthWidget(name: value.months[index],isChecked: value.selectedMonth==value.months[index],onTap: (s){
              getMonthsRange(s);
            },)),),)),

            SizedBox(height: 20,),
            Text('Total cashback: ${widget.historyCategory.summary!.received} SAR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

            SizedBox(height: 20,),

            widget.historyCategory.categoryId=='0'?Consumer<CommitmentsProvider>(builder:(context, value, child) => Expanded(child: ListView.builder(itemBuilder: (context, index) =>Container(margin: EdgeInsets.symmetric(vertical: 4),child: ContributorWidget(contributorModel: value.contributorsOfReceived[index],),),itemCount: value.contributorsOfReceived.length,))):Consumer<CommitmentsProvider>(builder:(context, value, child) => Expanded(child: ListView.builder(itemBuilder: (context, index) =>Container(margin: EdgeInsets.symmetric(vertical: 4),child:  ReceivedItem(order: value.ordersOfCategory[index],),),itemCount: value.ordersOfCategory.length,)))
          ],
        ),),
    );
  }
}






class ReceivedItem extends StatelessWidget {
   ReceivedItem({super.key,required this.order});
  Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(OrderDetails());
      },
      child: Container(
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
                    child: CachedNetworkImage(imageUrl: order.productImage??'',width: 120,
                      height: 120,
                      fit: BoxFit.cover,errorWidget: (context, url, error) =>Image.network('https://www.huber-online.com/daisy_website_files/_processed_/8/0/csm_no-image_d5c4ab1322.jpg',width: 120,
                          height: 120,
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${order.productName}',
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

                               Text(

                                'Cashback: ${order.cashback} SAR',
                                textAlign: TextAlign.end,
                                style: TextStyle(

                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                    color: kPurpleColor),

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
      ),
    );
  }
}