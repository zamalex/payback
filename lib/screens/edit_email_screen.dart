import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';
import '../providers/auth_provider.dart';
class EditEmailScreen extends StatelessWidget {
   EditEmailScreen({super.key});

   editData(BuildContext context){
     _formKey.currentState!.save();

     if(!_formKey.currentState!.validate()){
       return;
     }



     Map<String,String> request = {
       'email':'${email}',
       'password':'${password}',

     };

     Provider.of<AuthProvider>(context,listen: false).updateUserEmail(request).then((value){
       Get.snackbar('Response', value['message'],backgroundColor:value['data']?Colors.green: Colors.red,colorText: Colors.white);

     });
   }

  final _formKey = GlobalKey<FormState>();
  String email='';
  String password='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        title: Text('Edit email',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: TextButton.icon(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: kPurpleColor,), label: Text('Back',style: TextStyle(color: kPurpleColor),)),
      ),
      body: Consumer<AuthProvider>(
        builder:(context, value, child) => Form(
          key: _formKey,
          child: Container(
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
                            Text('Your email'),
                            SizedBox(height: 5,),
                            CustomTextField(type:TextInputType.emailAddress,hintText: 'mmm@yahoo.com',onSaved: (s){
                              email=s;
                            },),
                            SizedBox(height: 10,),
                            Text('Your password'),
                            SizedBox(height: 5,),
                            CustomTextField(hintText: 'Enter password',obscureText: true,onSaved: (s){
                              password=s;
                            },)
                            ,SizedBox(height: 20,),

                            value.isLoading?Center(child: CircularProgressIndicator(),):Container(
                                width:double.infinity,child: CustomButton(buttonText: 'Save changes', buttonColor: kPurpleColor,onTap: (){
                                  editData(context);
                            },)),

                      SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Forgot password?',style: TextStyle(color: kPurpleColor,fontWeight: FontWeight.bold),),
                      ],
                    ),


                          ],),
                        ],),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
