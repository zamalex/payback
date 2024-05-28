import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/model/share_details_response.dart';
import 'package:payback/providers/CommitmentsProvider.dart';
import 'package:payback/screens/main_screen.dart';
import 'package:provider/provider.dart';

import '../data/http/urls.dart';
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
  int user=0;
  String signature='';

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
          uri.queryParameters.forEach((key, value) {
            print(key);
            print(value);
          });
          id = int.parse(uri.queryParameters['commitment_id']??'0');
          user = int.parse(uri.queryParameters['user_id']??'0');
          signature = uri.queryParameters['signature']??'';
          sl<PreferenceUtils>().deleteInvitation();

          Provider.of<CommitmentsProvider>(context,listen: false).getInvitationDetails2(user,id);
        }

      });
    }
  }

  acceptRejectInvitation(int decision){
    if(decision==0){

      Get.to(MainScreen());

      return;
    }
    Map <String,dynamic> query = {
      'commitment_id':id,

      'user_id':user,

      'signature':signature,

    };
    FocusScope.of(context).requestFocus(FocusNode());
    Provider.of<CommitmentsProvider>(context,listen: false).acceptRejectInvitation({
      'amount':decision==0?0:int.parse(controller.text.replaceAll('%',''))/**100*/,
      'status':decision
    },query).then((value){
      Get.snackbar('Alert', value['message'],backgroundColor:value['data']?Colors.green: Colors.red,colorText: Colors.white);
      Get.to(MainScreen());
    });
  }


  TextEditingController controller = TextEditingController(text: '0%');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<CommitmentsProvider>(
          builder:(context, value, child) =>value.shareDetailsResponse==null?Center(child: Text('No available data')): Container(
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
                                            value.shareDetailsResponse?.data?.user?.avatarUrl??''))),
                                width: 70,
                                height: 70,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                value.shareDetailsResponse?.data?.user?.name??'',
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
                              _CommitmentOwner(shareCommit: value.shareDetailsResponse?.data?.commitment,shareUser: value.shareDetailsResponse?.data?.user,),
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
                                    '',//'20% available',
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
   _CommitmentOwner({super.key, this.shareCommit,this.shareUser});

  ShareUser? shareUser;
  ShareCommit? shareCommit;

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
                      CachedNetworkImage(
                      width: 25,
                      height: 25, imageUrl: shareCommit!.image??'',
                      errorWidget: (context, url, error) => Image.network(Url.ERROR_IMAGE,width: 25,height: 25,),
                      // color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      shareCommit==null?'':shareCommit!.name??'',
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
                Text('Owner: ${shareUser==null?'':shareUser!.name}',
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
