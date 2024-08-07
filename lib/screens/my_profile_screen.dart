import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/model/auth_response.dart';
import 'package:payback/screens/edit_address_screen.dart';
import 'package:payback/screens/login.dart';
import 'package:payback/screens/my_orders_screen.dart';
import 'package:payback/screens/notifications_screen.dart';
import 'package:payback/screens/notifications_settings_screen.dart';
import 'package:payback/screens/profile_info_screen.dart';
import 'package:payback/screens/settings_screen.dart';
import 'package:payback/screens/subscription_screen.dart';
import 'package:provider/provider.dart';

import '../data/http/urls.dart';
import '../data/service_locator.dart';
import '../providers/auth_provider.dart';

class MyProfileScreen extends StatefulWidget {
   MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final ImagePicker picker = ImagePicker();

  File? imageFile;

  updateAvatar(){
    Provider.of<AuthProvider>(context,listen: false).updateUserAvatar(imageFile!).then((value){
      Get.snackbar('Response', value['message'],backgroundColor:value['data']?Colors.green: Colors.red,colorText: Colors.white);
    });

  }
  pickImage()async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 50);
  if(image!=null){
    //setState(() {
      imageFile = File(image.path);
      Get.defaultDialog(title: 'change picture',middleText: 'Are you sure you want to change your picture?',onConfirm: (){updateAvatar();Get.back(closeOverlays: true);
      },onCancel: (){});
    //});
  }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<AuthProvider>(context, listen: false).getPlans();
    });
  }
// Pick an image.
  @override
  Widget build(BuildContext context) {


    return Consumer<AuthProvider>(
      builder:(context, value, child) {
        User user = sl<AuthResponse>().data!.user!;

        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Get.to(SettingsScreen());
                  },
                  child: Icon(
                    Icons.settings_outlined,
                    color: kBlueColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Get.to(NotificationsScreen());

                  },
                  child: Icon(
                    Icons.notifications_outlined,
                    color: kBlueColor,
                  ),
                ),
              ),
            ],
            centerTitle: true,
            title: Text(
              'My profile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leadingWidth: 100,
            leading: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: kPurpleColor,
                ),
                label: Text(
                  'Back',
                  style: TextStyle(color: kPurpleColor),
                )),
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        pickImage();
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(user.avatarUrl??''),fit: BoxFit.cover),
                            border: Border.all(color: Colors.white,width: 3),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            )),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircleAvatar(child: Icon(Icons.camera_alt,color: Colors.white,size: 20,),backgroundColor: kPurpleColor.withOpacity(.5),radius: 15,),
                            )
                          ],),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      width: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,children: [
                        Text(user.name??'',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.grey.shade800),),
                        Text(value.subscribedPlan!=null?'${value.subscribedPlan!.planName} subscription':'No subscription',style: TextStyle(fontSize: 18,color: Colors.grey),)
                      ],),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Card(
                  surfaceTintColor: Colors.white,

                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      if(Url.showSubscribe)
                      ProfileItem(text: 'Subscription',image: 'assets/images/subscription_crown.png',onTap:(){Get.to(SubscriptionScreen());}),
                      Divider(height: 30),
                      ProfileItem(text: 'My orders',image: 'assets/images/orders_list.png',onTap: (){
                        Get.to(MyOrdersScreen());
                      },),
                      Divider(height: 30,),

                      ProfileItem(text: 'Shipping address',image: 'assets/images/address_shipping.png',onTap: (){Get.to(EditAddressScreen());},)
                    ],),
                  ),
                )
                ,SizedBox(height: 20,),
                Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      ProfileItem(text: 'Edit profile info',color: Colors.grey.shade800,onTap: (){
                        Get.to(ProfileInfoScreen());
                      }),
                      Divider(height: 30),
                      ProfileItem(text: 'Notifications setting',color: Colors.grey.shade800,onTap: (){
                        Get.to(NotificationsSettingsScreen());

                      },),

                    ],),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(onTap:(){sl<PreferenceUtils>().logout();Get.to(LoginScreen());},child: Container(width:double.infinity,child: Card(surfaceTintColor:Colors.white,color: Colors.white,child: Padding(padding: EdgeInsets.all(16),child: Text('Log out',style: TextStyle(color: Colors.red),),),)))
              ],
            ),
          ),
        );
      },
    );
  }
}
class ProfileItem extends StatelessWidget {
   ProfileItem({super.key,this.image,required this.text,this.color=kBlueColor,this.showArrow= true,required this.onTap});

  String? image;
  String text;
  Color color;
  bool showArrow= true;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){onTap();},
      child: Container(
        color: Colors.white,
        child: Row(children: [
          image==null?Container():Container(child: Image.asset(image!,width: 20,height: 20,color: color,),margin: EdgeInsets.only(right: 10),),
          Expanded(child: Text(text,style: TextStyle(color: color,fontSize: 18),)) ,
         if(showArrow) Icon(Icons.arrow_forward_ios,color: kBlueColor,)
        ],),
      ),
    );
  }
}
