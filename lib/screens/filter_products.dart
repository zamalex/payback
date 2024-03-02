
import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_widgets.dart';
import '../model/partner_model.dart';

class FilterProducts extends StatelessWidget {
   FilterProducts({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController minController=TextEditingController(text: Provider.of<HomeProvider>(context).minPrice.toString());
    TextEditingController maxController=TextEditingController(text: Provider.of<HomeProvider>(context).maxPrice.toString());

    return  Container(
      margin: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(color: kBackgroundColor,borderRadius: BorderRadius.circular(8)),
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(0),
      child: Consumer<HomeProvider>(
        builder: (c,i,cc)=> Column(
          children: [
            Expanded(
              child: SingleChildScrollView(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16,).copyWith(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                      InkWell(child: Icon(Icons.close,color: Colors.red,),onTap:(){Navigator.of(context).pop();})
                    ],),
                    SizedBox(height: 5,),
                    Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                      Text('Filter products',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                      InkWell(
                          onTap: (){
                            i.resetFilters();
                          },
                          child: Text('Reset all',style: TextStyle(color: Colors.red,fontSize: 18),))
                    ],),
                    SizedBox(height: 10,),
                    Text('Price range(SAR)',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black54)),
                    SizedBox(height: 15,),

                    Row(children: [
                      Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('From'),
                        SizedBox(height: 5,),
                        CustomTextField(hintText: '',editable: false,controller: minController,)],)),
                      SizedBox(width: 15,),
                      Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text('To'),
                        SizedBox(height: 5,),
                        CustomTextField(hintText: '',controller: maxController,editable: false,)],))
                    ],),
                    SizedBox(height: 10,),

                    SliderTheme(
                      data: SliderThemeData(thumbColor: Color.fromRGBO(10, 91, 148, 1),activeTrackColor: Color.fromRGBO(53, 153, 220, 1)),
                      child: RangeSlider(
                        inactiveColor: Colors.grey.shade300,
                        //activeColor: Colors.blue,
                        values: RangeValues(i.minPrice, i.maxPrice),
                        max: 10000,

                        onChanged: (RangeValues values) {
                          i.changeRange(values.start, values.end);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Availability',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black54)),
                    SizedBox(height: 10,),
                    RadioListTile(value: 0, groupValue: 1, onChanged: (v){},title: Text('All',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),contentPadding: EdgeInsets.zero,activeColor: kBlueColor,)
                    ,RadioListTile(value: 1, groupValue: 1, onChanged: (v){},title: Text('In stock',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),contentPadding: EdgeInsets.zero,activeColor: kBlueColor,)
                    ,RadioListTile(value: 2, groupValue: 1, onChanged: (v){},title: Text('Out of stock',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),contentPadding: EdgeInsets.zero,activeColor: kBlueColor,)
                    ,SizedBox(height: 10,),
                    Text('Show partners products',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black54)),
                    SizedBox(height: 10,),

                    SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: List.generate(i.vendors.length, (index) => PartnerFilterWidget(vendor: i.vendors[index],)),),)



                  ],),
              ),),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),
              child: Container(
                  width:double.infinity,child: CustomButton(buttonText: 'Apply filters', buttonColor: kPurpleColor)),
            )
          ],
        ),
      ),

    );
  }

  List<int> selectedIndex = [1,3];
}

class PartnerFilterWidget extends StatelessWidget {
   PartnerFilterWidget({super.key,required this.vendor});

   Partner vendor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<HomeProvider>(context,listen: false).checkVendorInFilter(vendor.id);
      },
      child: Opacity(
        opacity: vendor.isChecked?1:.5,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 70,height: 70,
          decoration: BoxDecoration(image:DecorationImage(image: NetworkImage(vendor.image??'',),fit: BoxFit.cover),borderRadius: BorderRadius.circular(12),border: Border.all(color: vendor.isChecked?Colors.blue:Colors.transparent,width: 2)),
        ),
      ),
    );
  }
}
