import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:slide_switcher/slide_switcher.dart';
import '../helpers/custom_widgets.dart';

class PartnerDetailsScreen extends StatefulWidget {
  PartnerDetailsScreen({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
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
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuCxMPJwglskH6j6jQhCmJGqIr9kR6_iMPng&usqp=CAU',
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      title: Text(
                        'Partner name goes here',
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
                        'A trattoria is an Italian-style eating establishment that is generally much less formal than a ristorante, but more formal than an osteria.')
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
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (c, i) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: kBlueLightColor,
                            child: Image.network(
                              'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png',
                              width: 35,
                            ),
                            radius: 35,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Image 2',
                            style: TextStyle(
                              color: kBlueColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
                      showActionsheet();
                    },
                    icon: Icon(Icons.sort, color: kBlueColor),
                    label: Text('Best cashback'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.filter_alt_sharp, color: kBlueColor),
                    label: Text('Filter'),
                  ),
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
                      5,
                      (index) => ProductWidget()),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
