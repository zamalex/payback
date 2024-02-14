import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../model/partner_model.dart';
import '../providers/CommitmentsProvider.dart';

class NewCommitmentScreen extends StatefulWidget {
  const NewCommitmentScreen({super.key});

  @override
  State<NewCommitmentScreen> createState() => _NewCommitmentScreenState();
}

class _NewCommitmentScreenState extends State<NewCommitmentScreen> {
  int selected = 0;
  int type = 0;
  int selectedPercentage = 0;

  Partner? category;
  Partner? partner;

  String? name;
  String? payment_target;
  String? date;
  bool notify = false;

  final _formKey = GlobalKey<FormState>();

  createCommitment(){
    Map<String,String?> request={
      'name':name,
      'partner_id':partner ==null?null:'${partner!.id}',
      'category_id':category==null?null:'${category!.id}',
      'payment_target':payment_target,
      'cashback_to_commitment':'50',
      'due_date':date,
      'type':type==0?'one-time':'repeatable',
      'notify':notify?'1':'0',
    };

    Provider.of<CommitmentsProvider>(context,listen: false).createCommitment(request).then((value) {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<CommitmentsProvider>(context,listen: false).getCommitmentsCategories();
      Provider.of<HomeProvider>(context,listen: false).getPartners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leadingWidth: double.infinity,
        leading: Container(
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: kPurpleColor),
              )),
          margin: EdgeInsets.all(16),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New commitment',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SlideSwitcher(
                            containerColor: Colors.white,
                            slidersColors: const [
                              kBlueColor,
                            ],
                            containerBorder:
                                Border.all(color: Colors.white, width: 5),
                            children: [
                              Text(
                                'by SADAD',
                                style: TextStyle(
                                    color: selected == 0
                                        ? Colors.white
                                        : kBlueColor),
                              ),
                              Text(
                                'partners',
                                style: TextStyle(
                                    color: selected == 1
                                        ? Colors.white
                                        : kBlueColor),
                              ),
                            ],
                            onSelect: (index) {
                              setState(() {
                                selected = index;
                              });
                            },
                            containerHeight: 45,
                            containerWight:
                                MediaQuery.of(context).size.width - 32 - 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(selected==1?'Enter commitment name':'Enter SADAD'),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(onSaved:(v){name=v;},hintText:selected==1?'Type commitment name': 'Type SADAD number'),
                          SizedBox(
                            height: 15,
                          ),
                          if(selected==1)
                          Text('Choose partner'),
                          if(selected==1)

                            SizedBox(
                            height: 5,
                          ),
                          if(selected==1)

                            TextFieldButton(
                            hinttext: partner==null?'Choose partner':partner!.name??'',
                            onTap: () {
                              showPartnersSheet(context,(Partner p){setState(() {
                                partner=p;
                              });});
                            },
                          ),
                          if(selected==1)

                            SizedBox(
                            height: 15,
                          ),


                          Text('Choose category'),
                          SizedBox(
                            height: 5,
                          ),
                          TextFieldButton(
                            hinttext: category==null?'Choose category':category!.name??'',
                            onTap: () {
                              showCategoriesSheet(context,(Partner p){
                                setState(() {
                                  category=p;
                                });
                              });
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Payment target'),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(hintText: 'Minimum 10 SAR',onSaved: (v){payment_target=v;}),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cashback to commitments'),
                              Text(
                                '70% available',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GridView.count(
                              padding: EdgeInsets.all(5),
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              crossAxisCount: 5,
                              shrinkWrap: true,
                              children: List.generate(10, (index) {
                                return InkWell(
                                  onTap: () {
                                    if (((index + 1) * 10) <= 70)
                                      setState(() {
                                        selectedPercentage = index;
                                      });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ((index + 1) * 10) > 70
                                            ? Colors.grey.shade200
                                            : selectedPercentage == index
                                                ? kPurpleColor
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: selectedPercentage == index
                                                ? kPurpleColor
                                                : Colors.grey,
                                            width: 1)),
                                    margin: EdgeInsets.all(0),
                                    child: Center(
                                        child: Text(
                                      '${((index + 1) * 10)}%',
                                      style: TextStyle(
                                          color: selectedPercentage == index
                                              ? Colors.white
                                              : Colors.grey),
                                    )),
                                  ),
                                );
                              })),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Due date'),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                              hintText: 'Enter the date (DD/MM/YYYY)',onSaved: (v){date=v;},),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Commitment type',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: PaymentType(
                                    image: 'assets/images/one_time_commitment.png',
                                myIndex: 0,
                                selectedIndex: type,
                                txt: 'One time (deleted after completion)',
                                onTap: () {
                                  setState(() {
                                    type = 0;
                                  });
                                },
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: PaymentType(
                                    image: 'assets/images/repeatable_commitment.png',
                                myIndex: 1,
                                selectedIndex: type,
                                txt: 'Repeatable (renews after completion)',
                                onTap: () {
                                  setState(() {
                                    type = 1;
                                  });
                                },
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: kBlueLightColor.withOpacity(.5)),
                            padding: EdgeInsets.all(4),
                            child: SwitchListTile(
                              trackColor: notify?MaterialStateProperty.all(Colors.green):MaterialStateProperty.all(Colors.grey),
                              activeColor: Colors.white,
                              inactiveThumbColor: Colors.white,
                              title: Text(
                                'Notify me about goal completion',
                                style: TextStyle(
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              value: notify,
                              onChanged: (bool value) {
                                setState(() {
                                  notify = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Consumer<CommitmentsProvider>(
                  builder:(context, value, child) => value.isLoading?Center(child: CircularProgressIndicator(),): Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Container(
                        width: double.infinity,
                        child: CustomButton(onTap: (){createCommitment();},
                            buttonText: 'Create', buttonColor: kPurpleColor)),
                  ),
                )
              ],
            )),
      ),
    );
  }

  void showCategoriesSheet(BuildContext context,Function onSelected) {
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
        return Consumer<CommitmentsProvider>(
          builder:(context, value, child) => Container(
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
                    'Select category',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ]..addAll(List.generate(
                    value.commitmentsCategories.length,
                    (index) => Column(
                      children: [
                        ListTile(

                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: Icon(
                            Icons.airplanemode_active,
                            color: kPurpleColor,
                          ),
                          title: Text(
                            '${value.commitmentsCategories[index].name}',
                            style: TextStyle(fontSize: 15),
                          ),
                          onTap: () {
                            onSelected(value.commitmentsCategories[index]);Navigator.of(context).pop();
                          },
                        ),
                        index < 2 ? Divider() : Container()
                      ],
                    ),
                  ))),
          ),
        );
      },
    );
  }
}

void showPartnersSheet(BuildContext context,Function onSelected) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (BuildContext context) {
      return Consumer<HomeProvider>(
        builder:(context, value, child) => Container(
          height: MediaQuery.of(context).size.height * 0.95,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: kPurpleColor,
                      ),
                    )
                  ],
                ),
                Text(
                  'Choose partner',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(hintText: 'Search...'),
                SizedBox(
                  height: 10,
                )
              ]..addAll([
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: value.partners.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            onSelected(value.partners[index]);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: kBlueColor,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Icon(
                                    Icons.home,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    '${value.partners[index].name}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ])),
        ),
      );
    },
  );
}

class PaymentType extends StatelessWidget {
  PaymentType(
      {super.key,
      required this.myIndex,
      required this.selectedIndex,
      required this.txt,
        required this.image,
      required this.onTap});
  Function onTap;
  int myIndex;
  int selectedIndex;
  String txt;
  String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Radio(
                  value: myIndex, groupValue: selectedIndex, onChanged: (v) {}),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Image.asset(
                     image,
                      width: 48,
                      height: 48,
                      color:
                          myIndex == selectedIndex ? kBlueColor : Colors.grey,
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          txt,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: myIndex == selectedIndex
                                  ? kBlueColor
                                  : Colors.grey),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: myIndex == selectedIndex ? kBlueColor : Colors.grey,
                width: 1)),
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
