import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:provider/provider.dart';

import '../helpers/colors.dart';
import '../providers/CommitmentsProvider.dart';
import 'history_screen.dart';

class CommitmentCategorySpentScreen extends StatefulWidget {
  const CommitmentCategorySpentScreen({super.key});

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

  getCategoryCommitments() {
    Provider.of<CommitmentsProvider>(context, listen: false)
        .getCommitmentsOfCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonIcon(),
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
              child: Container(
                child: Icon(
                  Icons.calendar_month,
                  color: kBlueColor,
                ),
                margin: EdgeInsets.only(right: 16),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Consumer<CommitmentsProvider>(
          builder: (context, value, child) => value.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Home bills',
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
                                    getCategoryCommitments();
                                  },
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Total spent: 1200 SAR',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: Commitment(
                          commitment: value.commitmentsOfCategory[index],
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
