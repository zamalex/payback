import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/model/auth_response.dart';
import 'package:payback/model/cashback_dashboard.dart';
import 'package:provider/provider.dart';

import '../data/service_locator.dart';
import '../helpers/colors.dart';
import '../providers/CommitmentsProvider.dart';
import 'history_screen.dart';

class CommitmentCategorySpentScreen extends StatefulWidget {
  CommitmentCategorySpentScreen({super.key,required this.historyCategory});

  HistoryCategory historyCategory;

  @override
  State<CommitmentCategorySpentScreen> createState() =>
      _CommitmentCategorySpentScreenState();
}

class _CommitmentCategorySpentScreenState
    extends State<CommitmentCategorySpentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) => getCategoryCommitments());
  }


  DateTime? from;
  DateTime? to;

  getCategoryCommitments() {
    Provider.of<CommitmentsProvider>(context, listen: false)
        .getCommitmentsOfCategory({
      'category_id':widget.historyCategory.categoryId,
      'from':from,
      'to':to,
      'month':Provider.of<CommitmentsProvider>(context,listen: false).selectedMonth

    });
  }

  double calculateTotal(){
    double all =0;
    Provider.of<CommitmentsProvider>(context,listen: false).commitmentsOfCategory.forEach((element) {
      all+=double.parse(element.paymentTarget!);
    });

    return all;
  }


  getMonthsRange(String name){

      int monthIndex = Provider.of<CommitmentsProvider>(context,listen: false).months.indexOf(name) + 1;

      from = DateTime(DateTime.now().year, monthIndex, 1);
      to = DateTime(DateTime.now().year, monthIndex, 31);
      getCategoryCommitments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        actions: [
          InkWell(
              onTap: () {
                showCustomDateRangePicker(context,
                    dismissible: true,
                    minimumDate: DateTime(
                      1990,
                    ),
                    maximumDate: DateTime.now(),
                    onApplyClick: (one, two) {},
                    onCancelClick: () {},
                    backgroundColor: Colors.white,
                    primaryColor: kBlueColor);
              },
              child: InkWell(
                onTap: (){
                  showCustomDateRangePicker(context, dismissible: true, minimumDate:DateTime(1990,), maximumDate: DateTime.now(), onApplyClick: (one,two){
                    from= one;
                    to = two;

                    getCategoryCommitments();
                  }, onCancelClick: (){
                    from=null;
                    to = null;
                    getCategoryCommitments();
                  }, backgroundColor: Colors.white, primaryColor: kBlueColor);

                },
                child: Container(
                  child: Icon(
                    Icons.calendar_month,
                    color: kBlueColor,
                  ),
                  margin: EdgeInsets.only(right: 16),
                ),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Consumer<CommitmentsProvider>(
          builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.historyCategory.category??'',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            value.months.length,
                            (index) => MonthWidget(
                                  name: value.months[index],
                                  isChecked: value.selectedMonth ==
                                      value.months[index],
                                  onTap: (mon) {
                                    getMonthsRange(mon);
                                  },
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Total spent: ${calculateTotal()} SAR',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    value.isLoading
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        :  Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: Commitment(
                          commitment: value.commitmentsOfCategory[index],
                          another:true// sl<AuthResponse>().data!.user!.id!.toString()==value.commitmentsOfCategory[index].user_id.toString(),
                        ),
                      ),
                      itemCount: value.commitmentsOfCategory.length,
                    ))
                  ],
                ),
        ),
      ),
    );
  }
}
