import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/model/partner_custom_fields_response.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/partner_info_screen.dart';
import 'package:provider/provider.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:payback/model/commitment_model.dart'as c;

import '../model/partner_model.dart';
import '../providers/CommitmentsProvider.dart';

class NewCommitmentScreen extends StatefulWidget {

  NewCommitmentScreen({this.commitment});
  c.Commitment? commitment;

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
  DateTime? _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {

    DateTime _tomorrow = DateTime.now().add(Duration(days: 1));
    DateTime _fiveYearsLater = DateTime.now().add(Duration(days: 365 * 5 + 1));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tomorrow,
      firstDate: _tomorrow,
      lastDate: _fiveYearsLater,
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;

        date = '${_selectedDate?.year}-${_selectedDate?.month.toString().padLeft(2, '0')}-${_selectedDate?.day.toString().padLeft(2, '0')}';

      });
  }
  createCommitment(){

    _formKey.currentState!.save();
    bool isvalid = _formKey.currentState!.validate();
    if(!isvalid||date==null) {
      Get.snackbar('Alert', 'Fill required data',backgroundColor: Colors.red,colorText: Colors.white,);

      return;
    }

    Map<String,dynamic> request={
      'name':name,
      'partner_id':selected==0?1:partner ==null?null:'${partner!.id}',
      'category_id':category==null?null:'${category!.id}',
      'payment_target':payment_target,
      'cashback_to_commitment':((selectedPercentage+1)*10).toString(),
      'due_date':date,
      'type':type==0?'one-time':'repeatable',
      'notify':notify?'1':'0',
    };

    List<CustomField> customFields = Provider.of<HomeProvider>(context,listen: false).partnerCustomFields;
    if(customFields.isNotEmpty){
      Map<String,dynamic> partner_required = {};
      customFields.forEach((element) { 
        partner_required.putIfAbsent(element.fieldName, () => element.value);
      });
      
      request.putIfAbsent("partner_required", () => partner_required);
    }
    if(selected==0){
      request['name'] = 'SADAD';
      request.putIfAbsent("partner_required", () => {
        'sadad_num':name
      });

    }

    print(request.toString());
    Provider.of<CommitmentsProvider>(context,listen: false).createCommitment(request).then((value) {}).then((value) {
      Provider.of<HomeProvider>(context,listen: false).getCommitments();
      Get.back();
      Get.snackbar('Success', 'Commitment created',backgroundColor: Colors.green,colorText: Colors.white,);

    });

  }



  editCommitment(){

    _formKey.currentState!.save();
    bool isvalid = _formKey.currentState!.validate();
    if(!isvalid||date==null) {
      Get.snackbar('Alert', 'Fill required data',backgroundColor: Colors.red,colorText: Colors.white,);

      return;
    }

    Map<String,dynamic> request={
      'name':name,
      'partner_id':widget.commitment!.partnerId,
      'category_id':widget.commitment!.categoryId,
      'payment_target':double.parse(payment_target.toString()).toInt(),
      'cashback_to_commitment':((selectedPercentage+1)*10).toString(),
      'due_date':date,
      'type':type==0?'one-time':'repeatable',
      'notify':notify?'1':'0',
    };

    if(selected==0){
      request['name'] = 'SADAD';


    }

    print(jsonEncode(request));
    Provider.of<CommitmentsProvider>(context,listen: false).editCommitment(request,widget.commitment!.id??0).then((value) {}).then((value) {
      Provider.of<HomeProvider>(context,listen: false).getCommitments();
      Get.back();
      Get.snackbar('Success', 'Commitment Edited',backgroundColor: Colors.green,colorText: Colors.white,);

    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.commitment!=null){

      date=widget.commitment!.dueDate!;
      paymentTargetController.text=widget.commitment!.paymentTarget!;
      if(widget.commitment!.partnerId!=1){
        selected=1;
        nameController.text=widget.commitment!.name!;

      }
    }

    Future.delayed(Duration.zero).then((value) {
     Provider.of<HomeProvider>(context,listen: false).partnerCustomFields.clear();

      Provider.of<CommitmentsProvider>(context,listen: false).getCommitmentsCategories();
      Provider.of<HomeProvider>(context,listen: false).getPartners();
    });


  }

  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController paymentTargetController = TextEditingController();

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
                            widget.commitment!=null?'Edit commitment':'New commitment',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if(widget.commitment==null)SlideSwitcher(
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

                          if(selected==1&&widget.commitment==null)
                          Text('Choose partner'),
                          if(selected==1&&widget.commitment==null)

                            SizedBox(
                            height: 5,
                          ),
                          if(selected==1&&widget.commitment==null)

                            TextFieldButton(
                            hinttext: partner==null?'Choose partner':partner!.name??'',
                            onTap: () {
                              showPartnersSheet(context,(Partner p){setState(() {
                                partner=p;
                              });});
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(selected==1?'Enter commitment name':'Enter SADAD'),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(controller:nameController,onSaved:(v){name=v;},hintText:selected==1?'Type commitment name': 'Type SADAD number'),
                          SizedBox(
                            height: 15,
                          ),
                          if(selected==1&&widget.commitment==null)

                            SizedBox(
                            height: 15,
                          ),

                          if(widget.commitment==null)
                          Text('Choose category'),
                          if(widget.commitment==null)
                          SizedBox(
                            height: 5,
                          ),
                          if(widget.commitment==null)
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
                          CustomTextField(controller:paymentTargetController,hintText: 'Minimum 10 SAR',type: TextInputType.number,onSaved: (v){payment_target=v;}),
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
                                   // if (((index + 1) * 10) <= 70)
                                      setState(() {
                                        selectedPercentage = index;
                                      });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:/* ((index + 1) * 10) > 70
                                            ? Colors.grey.shade200
                                            : */selectedPercentage == index
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
                          TextFieldButton(controller:dateController,hinttext: date==null?'Enter the date (YYYY-MM-dd)':date??'', onTap: (){
                            _selectDate(context);
                          },showIcon: false,),
                          /*CustomTextField(
                              hintText: 'Enter the date (YYYY-MM-dd)',onSaved: (v){date=v;},type: TextInputType.datetime,),*/
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
                        child: CustomButton(onTap: (){ widget.commitment==null?createCommitment():editCommitment();},
                            buttonText: widget.commitment==null?'Create':'Edit', buttonColor: kPurpleColor)),
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
                          leading: Image.network(value.commitmentsCategories[index].image??'',width: 32,height: 32,),
                          title: Text(
                            '${value.commitmentsCategories[index].name}',
                            style: TextStyle(fontSize: 15),
                          ),
                          onTap: () {
                            onSelected(value.commitmentsCategories[index]);Navigator.of(context).pop();
                          },
                        ),
                        index < value.commitmentsCategories.length-1 ? Divider() : Container()
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
                           // onSelected(value.partners[index]);
                            Navigator.of(context).pop();
                            Get.to(PartnerInfoScreen(partner:value.partners[index],))?.then((list){
                              if(list!=null){
                                int partnerId = int.parse((list as List<CustomField>).first.partnerId??'0');
                                onSelected(value.partners.firstWhere((element) => element.id==partnerId));
                              }
                            });
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
                                  child: Image.network(
                                   value.partners[index].image??'',
                                    width: 70,
                                    height: 70,
                                   // color: Colors.white,
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
