import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/providers/CommitmentsProvider.dart';
import 'package:provider/provider.dart';

import '../data/service_locator.dart';
import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';
import '../model/auth_response.dart';

class InvitationScreen extends StatefulWidget {
  InvitationScreen({super.key});

  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  int id=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value){
      handleURI();
    });

  }

  handleURI() {
    if (sl.isRegistered<AuthResponse>()) {
      sl<PreferenceUtils>().readInvitation().then((value) {
        if(value!=null){
          Uri uri = Uri.parse(value);
          id = int.parse(uri.queryParameters['id']??'0');
          sl<PreferenceUtils>().deleteInvitation();

          Provider.of<CommitmentsProvider>(context,listen: false).getInvitationDetails(id);
        }

      });
    }
  }

  acceptRejectInvitation(int decision){

    FocusScope.of(context).requestFocus(FocusNode());
    Provider.of<CommitmentsProvider>(context,listen: false).acceptRejectInvitation({
      'amount':decision==0?0:int.parse(controller.text.replaceAll('%','')),
      'status':decision
    },id).then((value){
      Get.snackbar('Alert', value['message'],backgroundColor: Colors.red,colorText: Colors.white);
    });
  }


  TextEditingController controller = TextEditingController(text: '0%');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<CommitmentsProvider>(
          builder:(context, value, child) => Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/auth_background.png'))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVR9V1Ix26V2s_WWWryH3FU5Qkl2yR4PL3BcUybf2cUw&s'))),
                                width: 70,
                                height: 70,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Mustafa Ezzeldin',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              Text(
                                'is asking you to share your cashback for commitment',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _CommitmentOwner(),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'How much to share?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  Text(
                                    '20% available',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: kBlueColor.withOpacity(.2)),
                                  padding: EdgeInsets.all(0),
                                  child: Center(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value){
                                        String numericValue = value.replaceAll(RegExp(r'[^0-9.]'), '');

                                        // Check if numericValue is not empty
                                        if (numericValue.isNotEmpty) {
                                          // Parse the numeric value
                                          int numericDouble = int.parse(numericValue);

                                          // Format the value with a percentage symbol
                                          String formattedValue = '$numericDouble%';

                                          // Update the controller's text
                                          controller.value = controller.value.copyWith(
                                            text: formattedValue,
                                            selection: TextSelection.collapsed(offset: formattedValue.length),
                                          );
                                        }
                                      },

                                      style:  TextStyle(
                                          color: kBlueColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40),
                                      controller: controller,
                                      textAlign: TextAlign.center, // Center-align the text
                                      decoration: InputDecoration(
                                        // Remove underline by setting `border` to `InputBorder.none`
                                        border: InputBorder.none,
                                        // Optionally, you can customize other properties like hintText, hintStyle, etc.
                                        //hintText: 'Enter text',
                                        hintStyle: TextStyle(color: Colors.grey),
                                      ),
                                    ), /*Text(
                                      '0%',
                                      style: TextStyle(
                                          color: kBlueColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40),
                                    ),*/
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Tap the field to chaneg the cashback sharing percentage',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                value.isLoading?Center(child: CircularProgressIndicator(),):Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
                  child: Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                            onTap: (){
                            acceptRejectInvitation(0);

                            },
                              buttonText: 'Decline', buttonColor: Colors.red)),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: CustomButton(
                            onTap: (){
                              acceptRejectInvitation(1);
                                                          },
                              buttonText: 'Accept & Share',
                              buttonColor: kPurpleColor)),
                    ],
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

class _CommitmentOwner extends StatelessWidget {
  const _CommitmentOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      //height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.centerRight,
          colors: [
            Colors.blue.shade900,
            Colors.blue.shade800,
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Image.asset(
                      'assets/images/travel.png',
                      width: 25,
                      height: 25,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Netflix sub',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                )),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Owner: Mustafa Ezzeldin Ahmad',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
