import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/filter_products.dart';
import 'package:payback/screens/saved_screen.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';
import '../helpers/custom_widgets.dart';
import '../providers/home_provider.dart';

class ShopOnlineScreen extends StatefulWidget {
  ShopOnlineScreen({Key? key}) : super(key: key);

  @override
  State<ShopOnlineScreen> createState() => _ShopOnlineScreenState();
}

class _ShopOnlineScreenState extends State<ShopOnlineScreen> {
  int selected = 0;

  sortProducts() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('Sort products by'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Best cashback',style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Popular',style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Hot deals',style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Price : lowest to high',style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Price : highest to low',style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Name : A-Z',style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Name : Z-A',style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel',style: TextStyle(color: kBlueColor)),
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          )),
    );
  }
  sortPartners() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('Sort partners by'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Best cashback',style: TextStyle(color: Colors.blue),),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Popular',style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),

            CupertinoActionSheetAction(
              child: const Text('Name : A-Z',style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Name : Z-A',style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context, 'Delete For Everyone');
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel',style: TextStyle(color: kBlueColor)),
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          )),
    );
  }


  showFilterSheet(BuildContext context){
    showModalBottomSheet(backgroundColor: Colors.transparent,isScrollControlled: true,context: context, builder: (context) => Container(margin:EdgeInsets.only(top: 40),child: FilterProducts()),useSafeArea: true,);
  }

  getPartners(){
    Provider.of<HomeProvider>(context,listen: false
    ).getPartners();
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((value) => getPartners());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder:(c,provider,cc)=> SafeArea(
          child: Container(
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
                          'Shop online',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.to(SavedScreen());
                        },
                        icon: Image.asset('assets/images/save_inactive.png',color: kBlueColor,),
                        label: Text('Saved',style: TextStyle(color: kBlueColor),),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
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
                  CustomTextField(
                    hintText: 'search...',
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          selected==0?sortProducts():sortPartners();
                        },
                        icon: Icon(Icons.sort, color: kBlueColor),
                        label: Text('Best cashback'),
                      ),
                      if(selected==0)TextButton.icon(
                        onPressed: () {
                          showFilterSheet(context);
                        },
                        icon: Icon(Icons.filter_alt_sharp, color: kBlueColor),
                        label: Text('Filter'),
                      ),
                    ],
                  ),
                  Container(height: 10),
                  Container(
                    height: 100,
                    child: Consumer<HomeProvider>(
                      builder:(context, value, child) =>  ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.categories!.length,
                        itemBuilder: (c, i) {
                          return CategoryWidget(category: value.categories![i]);
                        },
                      ),
                    ),
                  ),
                  Container(height: 10),
                  Container(
                    child: selected == 0
                        ? GridView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: .6,
                                    crossAxisSpacing: 0,
                                    crossAxisCount: 2),
                            children: List.generate(
                                5,
                                (index) => ProductWidget()),
                          )
                        : GridView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: .7,
                                    crossAxisSpacing: 8,
                                    crossAxisCount: 2),
                            children: List.generate(
                                provider.partners.length,
                                (index) => PartnerWidget(partner: provider.partners[index],)),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
