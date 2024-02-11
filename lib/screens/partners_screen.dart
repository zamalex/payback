import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:slide_switcher/slide_switcher.dart';
import '../helpers/custom_widgets.dart';
import 'filter_products.dart';

class PartnersScreen extends StatefulWidget {
  PartnersScreen({Key? key}) : super(key: key);

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        leading: TextButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kPurpleColor,
            ),
            label: Text('Back',style: TextStyle(color: kPurpleColor),)),
        title: Text('Partners list'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Your city',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 12),
                    ),
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    showCitiesSheet(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'City',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Icon(Icons.list)
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 1)),
                  )),
              Container(height: 20),
              Container(
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .7,
                      crossAxisSpacing: 8,
                      crossAxisCount: 2),
                  children: List.generate(5, (index) => PartnerWidget()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showCitiesSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: Colors.white),
          padding: EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select your city',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                )
              ]..addAll(List.generate(
                  3,
                  (index) => Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          'Riyadh',
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          // Handle settings tile tap
                        },
                      ),
                      index < 2 ? Divider() : Container()
                    ],
                  ),
                ))),
        );
      },
    );
  }
}
