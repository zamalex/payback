import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';
class EditNameScreen extends StatelessWidget {
   EditNameScreen({super.key});

  editData(BuildContext context){
    _formKey.currentState!.save();

    if(!_formKey.currentState!.validate()){
      return;
    }



    Map<String,String> request = {
      'name':'${firstName} ${lastName}',
      'first_name':firstName,
      'last_name':lastName
    };

    Provider.of<AuthProvider>(context,listen: false).updateUserData(request).then((value){
      Get.snackbar('Response', value['message'],backgroundColor:value['data']?Colors.green: Colors.red,colorText: Colors.white);
    });
  }

  final _formKey = GlobalKey<FormState>();
  String firstName='';
  String lastName='';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leadingWidth: 100,
          title: Text('Edit name',style: TextStyle(fontWeight: FontWeight.bold),),
          leading: TextButton.icon(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: kPurpleColor,), label: Text('Back',style: TextStyle(color: kPurpleColor),)),
        ),
        body: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),

                        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Text('First name'),
                          SizedBox(height: 5,),
                          CustomTextField(hintText: 'Enter first name',obscureText: false,onSaved: (s){
                            firstName = s;
                          },),
                          SizedBox(height: 10,),
                          Text('Last name'),
                          SizedBox(height: 5,),
                          CustomTextField(hintText: 'Enter last name',obscureText: false,onSaved: (s){
                            lastName = s;
                          },)
                          ,SizedBox(height: 20,),

                          Consumer<AuthProvider>(
                            builder:(context, value, child) =>value.isLoading?Center(child: CircularProgressIndicator(),): Container(
                                width:double.infinity,child: CustomButton(buttonText: 'Save changes', buttonColor: kPurpleColor,onTap: (){
                                  editData(context);
                            },)),
                          ),

                          SizedBox(height: 20,),




                        ],),
                      ],),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
