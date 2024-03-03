import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';
import '../helpers/custom_widgets.dart';
import '../model/cities_response.dart';
import 'filter_products.dart';

class PartnersScreen extends StatefulWidget {
  PartnersScreen({Key? key}) : super(key: key);

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value){
      Provider.of<HomeProvider>(context,listen: false).getCities();
      Provider.of<HomeProvider>(context,listen: false).getVendors();
    });
  }


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
      body: Consumer<HomeProvider>(
        builder:(context, value, child) =>  Container(
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
                      showCitiesSheet(context,value.cities);
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
                    children: List.generate(value.vendors.length, (index) => PartnerWidget(partner: value.vendors[index])),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  void showCitiesSheet(BuildContext context,List<City> cities) {
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
                  cities.length,
                  (index) => Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          cities[index].name,
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          // Handle settings tile tap
                        },
                      ),
                      index < cities.length-1 ? Divider() : Container()
                    ],
                  ),
                ))),
        );
      },
    );
  }
}
