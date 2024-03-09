import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/model/partner_model.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';
import '../helpers/custom_widgets.dart';
import '../providers/home_provider.dart';

class PartnerDetailsScreen extends StatefulWidget {
  PartnerDetailsScreen({Key? key,required this.partner}) : super(key: key);

  Partner partner;

  @override
  State<PartnerDetailsScreen> createState() => _PartnerDetailsScreenState();
}

class _PartnerDetailsScreenState extends State<PartnerDetailsScreen> {
  showActionsheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('Sort products by'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Best cashback'),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Popular'),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Hot deals'),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Price : lowest to high'),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Price : highest to low'),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Name : A-Z'),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Name : Z-A'),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    Future.delayed(Duration.zero).then((value){


      Provider.of<HomeProvider>(context,listen: false).initSearchControllerVendor();
      
      
      getVendorProducts();
    });
  }

  getVendorProducts(){

  

    Provider.of<HomeProvider>(context,listen: false).getProducts(location: 'VENDOR',vendorIDs: [widget.partner.id]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<HomeProvider>(
        builder:(context, value, child) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: kBlueLightColor),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                   widget.partner.image??'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuCxMPJwglskH6j6jQhCmJGqIr9kR6_iMPng&usqp=CAU',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        title: Text(
                          widget.partner.name??'',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          widget.partner.description??'')
                    ],
                  ),
                ),
                Container(height: 20),
                Text(
                  'Partner products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 10,
                ),
                Consumer<HomeProvider>(
                  builder:(context, value, child) => Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:value.categories==null?0:value.categories!.length,itemBuilder: (c,i){
                      return  CategoryWidget(category: value.categories![i],isSelected: value.selectedVendoDetailsIndex==i,onTap: (){value.selectVendorDetailsIndex(i,[widget.partner.id]);},);
                    }),
                  ),
                ),
                Container(height: 20),
                CustomTextField(
                  controller:       Provider.of<HomeProvider>(context,listen: false).searchControllerVendor
                  ,
                  hintText: 'search...',
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        showActionsheet();
                      },
                      icon: Icon(Icons.sort, color: kBlueColor),
                      label: Text('Best cashback'),
                    ),
                    /*TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.filter_alt_sharp, color: kBlueColor),
                      label: Text('Filter'),
                    ),*/
                  ],
                ),
                Container(
                  child: Container(
                      child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .6,
                        crossAxisSpacing: 8,
                        crossAxisCount: 2),
                    children: List.generate(
                        value.vendorProducts.length,
                        (index) => ProductWidget(product: value.vendorProducts[index])),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
