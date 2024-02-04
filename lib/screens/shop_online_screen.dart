import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:slide_switcher/slide_switcher.dart';
import '../helpers/custom_widgets.dart';

class ShopOnlineScreen extends StatefulWidget {
  ShopOnlineScreen({Key? key}) : super(key: key);

  @override
  State<ShopOnlineScreen> createState() => _ShopOnlineScreenState();
}

class _ShopOnlineScreenState extends State<ShopOnlineScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.battery_saver, color: kBlueColor),
                    label: Text('Saved'),
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
                    style: TextStyle(color: selected == 0 ? Colors.white : kBlueColor),
                  ),
                  Text(
                    'Partners',
                    style: TextStyle(color: selected == 1 ? Colors.white : kBlueColor),
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
                    onPressed: () {},
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
              Container(height: 10),
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
              Container(height: 10),
              Container(
                child: selected==0?GridView(

                  physics:NeverScrollableScrollPhysics(),shrinkWrap: true,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio:.6,crossAxisSpacing: 8,crossAxisCount: 2),children: List.generate(5, (index) =>  Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    // width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.topCenter,
                          // width: 170,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuCxMPJwglskH6j6jQhCmJGqIr9kR6_iMPng&usqp=CAU'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Earn 100 SAR',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.purple,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              CircleAvatar(
                                radius: 15,
                                child: Icon(
                                  Icons.battery_saver_rounded,
                                  color: Colors.blue,
                                ),
                                backgroundColor: Colors.white,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Nike shop',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          '2000 SAR',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          'Snakers shoe women',
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                )),):GridView(

                  physics:NeverScrollableScrollPhysics(),shrinkWrap: true,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio:.7,crossAxisSpacing: 8,crossAxisCount: 2),children: List.generate(5, (index) =>  Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    // width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.topCenter,
                          // width: 170,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuCxMPJwglskH6j6jQhCmJGqIr9kR6_iMPng&usqp=CAU'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: false,
                                child: Container(
                                  child: Text(
                                    'Earn 100 SAR',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 15,
                                child: Icon(
                                  Icons.battery_saver_rounded,
                                  color: Colors.blue,
                                ),
                                backgroundColor: Colors.white,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Nike shop',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),

                      ],
                    ),
                  ),
                )),),
              )
            ],
          ),
        ),

      ),
    ),);
  }
}
