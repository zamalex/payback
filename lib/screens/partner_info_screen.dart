import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/model/partner_model.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/register.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_widgets.dart';

class PartnerInfoScreen extends StatefulWidget {
   PartnerInfoScreen({Key? key,this.partner}) : super(key: key);

  Partner? partner;

  @override
  State<PartnerInfoScreen> createState() => _PartnerInfoScreenState();
}

class _PartnerInfoScreenState extends State<PartnerInfoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<HomeProvider>(context,listen: false).getPartnerCustomFields(widget.partner!.id);
    });
  }
  final _formKey = GlobalKey<FormState>();

  savePartnerInfo(){

    if(_formKey.currentState!.validate()){
      Get.back(result: Provider.of<HomeProvider>(context,listen: false).partnerCustomFields);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(),
        padding: EdgeInsets.all(0),
        child: SafeArea(
          child: Column(
            children: [
              Consumer<HomeProvider>(
                builder:(context, provider, child) => Form(
                  key: _formKey,
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '${widget.partner!.name??""}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'Please, fill in the data that required to pay for this partner commitment'),
                              SizedBox(
                                height: 20,
                              ),

                              Column(
                                children: List.generate(provider.partnerCustomFields.length, (index){
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${provider.partnerCustomFields[index].displayName}',
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CustomTextField(hintText: '${provider.partnerCustomFields[index].displayName}'),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  );
                                }),
                              ),

                             ]),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),

                child:   Container(
                    width: double.infinity,
                    child: CustomButton(buttonText: 'Continue', buttonColor: kPurpleColor,onTap: (){
                      savePartnerInfo();
                    },)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
