import 'package:flutter/material.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:slide_switcher/slide_switcher.dart';


class NewCommitmentScreen extends StatefulWidget {
  const NewCommitmentScreen({super.key});

  @override
  State<NewCommitmentScreen> createState() => _NewCommitmentScreenState();
}

class _NewCommitmentScreenState extends State<NewCommitmentScreen> {
  int selected =0;
  int type = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: Container(
          child: Text('Close',style: TextStyle(color: kPurpleColor),),
          margin: EdgeInsets.all(16),
        ),
        backgroundColor: Colors.grey.shade100,
      ),
      body: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New commitment',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SlideSwitcher(
                      containerColor: Colors.white,
                      slidersColors: const [
                        kBlueColor,
                      ],
                      containerBorder: Border.all(color: Colors.white,width: 5),
                      children: [
                        Text('by SADAD',style: TextStyle(color: selected==0?Colors.white:kBlueColor),),
                        Text('partners',style: TextStyle(color: selected==1?Colors.white:kBlueColor),),
                      ],
                      onSelect: (index) {
                        setState(() {
                          selected=index;
                        });
                      },
                      containerHeight: 45,
                      containerWight: MediaQuery.of(context).size.width-32-10,
                    ),
                    SizedBox(height: 20,),

                    Text('Enter SADAD'),
                    SizedBox(height: 5,),
                    CustomTextField(hintText: 'Type SADAD number'),
                    SizedBox(height: 15,),
                    Text('Enter SADAD'),
                    SizedBox(height: 5,),
                    TextFieldButton(hinttext: 'Choose category'),
                    SizedBox(height: 15,),
                    Text('Payment target'),
                    SizedBox(height: 5,),
                    CustomTextField(hintText: 'Minimum 10 SAR'),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cashback to commitments'),
                        Text('70% available',style: TextStyle(color: Colors.green),),

                      ],
                    ),
                    SizedBox(height: 5,),
                    GridView.count(
                        crossAxisCount: 5,
                        shrinkWrap: true,
                        children: List.generate(10, (index) {
                          return Container(
                            margin: EdgeInsets.all(4),
                            child: Card(
                              elevation: 0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(color: Colors.grey,width: 1)
                                ),
                                child: Center(
                                    child: Text('10%'))),
                          );})),
                    SizedBox(height: 15,),
                    Text('Due date'),

                    SizedBox(height: 5,),
                    CustomTextField(hintText: 'Enter the date (DD/MM/YYYY)'),
                    SizedBox(height: 15,),
                    Text('Commitment type', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Expanded(child: PaymentType(myIndex: 0,selectedIndex:type,txt:'One time (deleted after completion)',onTap: (){
                          setState(() {
                            type=0;
                          });
                        },)),

                        SizedBox(width: 15,),
                        Expanded(child: PaymentType(myIndex: 1,selectedIndex:type,txt:'Repeatable (renews after completion)',onTap: (){
                          setState(() {
                            type=1;
                          });
                        },)),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: kBlueLightColor.withOpacity(.5)
                      ),
                      padding: EdgeInsets.all(4),
                      child:   SwitchListTile(
                        trackColor: MaterialStateProperty.all(Colors.green),
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        title: Text('Notify me about goal completion',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold,fontSize: 15),),
                        value: true,
                        onChanged: (bool value) {

                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),
            child: Container(
                width:double.infinity,child: CustomButton(buttonText: 'Create', buttonColor: kPurpleColor)),
          )
        ],
      )
      ),
    );
  }
}


class PaymentType extends StatelessWidget {
   PaymentType({super.key, required this.myIndex,required this.selectedIndex,required this.txt,required this.onTap});
  Function onTap;
  int myIndex;
  int selectedIndex;
  String txt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        child: Stack(
          children: [
            Positioned(top: 0,right: 0,child: Radio(value: myIndex, groupValue: selectedIndex, onChanged: (v){}),),
            Center(
              child:Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Icon(Icons.payments_rounded,size: 50,color: myIndex==selectedIndex?kBlueColor:Colors.grey,),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(txt,textAlign: TextAlign.center,style: TextStyle(color: myIndex==selectedIndex?kBlueColor:Colors.grey),))
                  ],
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16),border: Border.all(color: myIndex==selectedIndex?kBlueColor:Colors.grey,width: 1)),
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
