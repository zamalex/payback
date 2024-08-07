import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';
import '../helpers/custom_widgets.dart';
import 'filter_products.dart';

class SavedScreen extends StatefulWidget {
  SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  int selected = 0;
  showFilterSheet(BuildContext context){
    showModalBottomSheet(backgroundColor: Colors.transparent,isScrollControlled: true,context: context, builder: (context) => Container(margin:EdgeInsets.only(top: 40),child: FilterProducts()),useSafeArea: true,);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value){
      Provider.of<HomeProvider>(context,listen: false).getSavedProducts();
      Provider.of<HomeProvider>(context,listen: false).getSavedVendors();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: mainAppBar(),
      body: Consumer<HomeProvider>(
        builder:(context, value, child) => Container(
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
                        'Saved',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ],
                ),
                Container(height: 10),
                SlideSwitcher(
                  containerColor: Colors.white,
                  slidersColors: const [
                    kBlueColor,
                  ],
                  containerBorder: Border.all(color: Colors.white, width: 5),
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                          color: selected == 0 ? Colors.white : kBlueColor),
                    ),
                    Text(
                      'Partners',
                      style: TextStyle(
                          color: selected == 1 ? Colors.white : kBlueColor),
                    ),
                  ],
                  onSelect: (index) {
                    setState(() {
                      selected = index;
                    });
                  },
                  containerHeight: 45,
                  containerWight: MediaQuery.of(context).size.width - 32 - 10,
                ),
                Container(height: 20),
                Container(
                  child: selected == 0
                      ? GridView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: .6,
                              crossAxisSpacing: 0,
                              crossAxisCount: 2),
                          children: List.generate(
                              value.savedProducts.length,
                              (index) => ProductWidget(product: value.savedProducts[index],)),
                        )
                      : GridView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: .7,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2),
                          children: List.generate(
                              value.savedVendors.length,
                              (index) => PartnerWidget(partner: value.savedVendors[index])),
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
