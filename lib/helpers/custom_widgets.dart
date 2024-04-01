import 'dart:convert';
import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:payback/data/http/urls.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/model/categories_response.dart';
import 'package:payback/model/product_model.dart';
import 'package:payback/model/commitment_model.dart' as com;
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/commitmetn_details_screen.dart';
import 'package:payback/screens/partner_details_screen.dart';
import 'package:payback/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../model/banches_response.dart';
import '../model/partner_model.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;

  bool obscureText = false;
  bool isFullName = false;
  TextInputType type = TextInputType.text;

  Widget? icon = null;
  bool editable = true;

  bool isPassword = false;
  bool showCountryCode = false;
  String? selectedCode;



  CustomTextField(
      {required this.hintText,
      this.obscureText = false,
      this.type = TextInputType.text,
        this.onChanged,
      this.controller,
      this.icon,
        this.selectedCode,
      this.isPassword = false,
      this.isFullName = false,
      this.showCountryCode = false,
      this.editable = true,
      this.maxLines = 1,
      this.onSaved});

  TextEditingController? controller;
  int maxLines = 1;
  Function? onSaved;
  Function? onChanged;
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }

    // Split the full name by spaces
    List<String> names = value.trim().split(' ');

    // Check if there are at least two names
    if (names.length < 2) {
      return 'Please enter your first name and last name';
    }

    // You can add more complex validation rules here if needed
    return null;
  }
  String selectedCode = '+20';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.selectedCode!=null){
      selectedCode=widget.selectedCode!;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: widget.maxLines * 48.0,
      child: TextFormField(

        validator: (text) {
          if (text!.isEmpty) {
            return 'Enter required data';
          }
          if(widget.isFullName){
            return _validateFullName(text);
          }

          if (widget.type == TextInputType.phone && text.startsWith('0')) {
            return 'Phone shouldn\'t start with 0';
          }

       if (widget.type == TextInputType.emailAddress && !GetUtils.isEmail(text)) {
            return 'Enter valid email';
          }

          if (widget.isPassword&&!validateStructure(text)) {
            return 'password should contain upper and lower case,\n numbers and special characters';
          } else
            return null;
        },
        onSaved: (s) {
          print('saved $s');
          if (widget.onSaved != null) widget.onSaved!(widget.showCountryCode?'${selectedCode}$s':s);
        },
        readOnly: !widget.editable,
        maxLines: widget.maxLines,
        controller: widget.controller,
        onChanged: (s){
          if (widget.onChanged != null) widget.onChanged!(s);

        },
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          fillColor: Colors.white, // Custom background color
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: widget.maxLines * (12), horizontal: 10),
          prefixIcon: widget.showCountryCode?Container(
              //height: 20,
              child: CountryCodePicker(

                initialSelection: selectedCode,
                onChanged: (c){
                  selectedCode = (c.dialCode?..replaceAll('+', ''))!;

              },)):null,
          suffixIcon: IconButton(
            icon: widget.isPassword
                ? Icon(widget.obscureText
                    ? Icons.visibility
                    : Icons.visibility_off)
                : widget.icon ?? Icon(null),
            onPressed: () {
              if (widget.isPassword)
                setState(() {
                  widget.obscureText = !widget.obscureText;
                });
            },
          ),
        ),
        keyboardType: widget.type,
      ),
    );
  }
}

class TextFieldButton extends StatelessWidget {
  String hinttext;
  Function onTap;
  bool showIcon = true;
  TextEditingController? controller;
  TextFieldButton({required this.hinttext, required this.onTap,this.showIcon=true,this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 48.0,
        child: TextField(
          controller: controller,
          enabled: false,
          decoration: InputDecoration(
            fillColor: Colors.white, // Custom background color
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            hintText: hinttext,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            suffixIcon:!showIcon?null: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}

class BottomZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var smallLineLength = size.width / 20;
    const smallLineHeight = 12;
    var path = Path();

    path.lineTo(0, size.height);
    for (int i = 1; i <= 20; i++) {
      if (i % 2 == 0) {
        path.lineTo(smallLineLength * i, size.height);
      } else {
        path.lineTo(smallLineLength * i, size.height - smallLineHeight);
      }
    }
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  Function? onTap;
  Color textColor = Colors.white;

  CustomButton(
      {required this.buttonText,
      required this.buttonColor,
      this.onTap,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if (onTap != null) onTap!();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // Custom color for the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String buttonText;
  final String iconData;
  final Color buttonColor;
  final Color iconColor;

  Function? onTap;

  CustomIconButton(
      {required this.buttonText,
      required this.iconData,
      this.onTap,
      this.buttonColor = Colors.white,
      this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (onTap != null) onTap!();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // Custom color for the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      icon: Image.asset(
        iconData,
      ),
      label: Text(
        buttonText,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(12.0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final rect = Rect.fromCenter(center: center, width: 6.0, height: 12);

    // Draw black rounded rect with white stroke
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(6.0)),
      strokePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(6.0)),
      paint,
    );
  }
}

class Commitment extends StatelessWidget {
  Commitment({super.key, this.commitment});

  com.Commitment? commitment;

  int i = Random().nextInt(shade0.length);

  @override
  Widget build(BuildContext context) {
    if (commitment == null)
      commitment = com.Commitment.fromJson(jsonDecode(Url.COMMITMENT_JSON));
    return InkWell(
      onTap: () {
        Get.to(CommitmetDetails(commitment: commitment!,));
      },
      child: Container(
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
              shade0[i],//Colors.blue.shade900,
              shade1[i]//Colors.blue.shade800,
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
                      commitment!.image==null?Icon(Icons.hourglass_empty,color: Colors.white,):Image.network(
                        commitment!.image??'',
                        width: 25,
                        height: 25,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${commitment!.name ?? ''}',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  )),
                  Text(
                    '${commitment!.paymentTarget ?? '0'} SAR',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              child: SliderTheme(
                data: SliderThemeData(thumbShape: CustomThumbShape()),
                child: Slider(
                  activeColor: Colors.teal,

                  min: 0.0,
                  max: 100.0,
                  value: 100,
                  // divisions: 10,
                  label: '100',
                  onChanged: (value) {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('100% collected',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                  Text('0 SAR left',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

AppBar mainAppBar() {
  return AppBar(
    backgroundColor: kBackgroundColor,
    elevation: 0,
    leading: Row(
      children: [
        TextButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
            label: Text('Back')),
      ],
    ),
    leadingWidth: double.infinity,
  );
}

class CategoryWidget extends StatelessWidget {
  CategoryWidget(
      {super.key, required this.category, this.isSelected = false, this.onTap});
  Category category;

  bool isSelected = false;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        width: 70,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? kBlueColor : kBlueLightColor,
              child: Image.network(
                category.image ??
                    'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png',
                width: 35,
              ),
              radius: 35,
            ),
            SizedBox(height: 8),
            Text(
              category.name ?? '',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: kBlueColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  ProductWidget({super.key, this.product,});



  Product? product = Product.fromJson(jsonDecode(Url.PRODUCT_JSON));

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      product = Product.fromJson(jsonDecode(Url.PRODUCT_JSON));
    }
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(
          product: product!,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          product!.featuredImage ??
                              'https://cdn-images.buyma.com/imgdata/item/230807/0097589320/564300514/428.jpg',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'Earn 100 SAR',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.purple,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    InkWell(
                      onTap: (){
                        Provider.of<HomeProvider>(context,listen: false).saveProduct(product!);
                      },
                      child: Consumer<HomeProvider>(
                        builder:(context, value, child) => CircleAvatar(
                          radius: 15,
                          child: value.isLoading?CircularProgressIndicator():Image.asset(
                            value.savedProducts.any((element) => element.id==product!.id)||product!.isSaved
                                ? 'assets/images/save_active.png'
                                : 'assets/images/save_inactive.png',
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${product!.name ?? ''}',
                style: TextStyle(
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text('${product!.price ?? '0'} SAR',
                  style: TextStyle(color: Colors.purple, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              Text(product!.description ?? '',
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1)
            ],
          ),
        ),
      ),
    );
  }
}

class PartnerWidget extends StatelessWidget {
  PartnerWidget({super.key, this.partner,this.branch});

  Partner? partner;

  Branch? branch;

  @override
  Widget build(BuildContext context) {
    if (partner == null)
      partner = Partner.fromJson(jsonDecode(Url.PARTNER_JSON));

    if(branch!=null)
      partner = branch!.vendor;
    return InkWell(
      onTap: () {
        Get.to(PartnerDetailsScreen(
          partner: partner!,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          // width: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.topCenter,
                // width: 170,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(partner!.image ??
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuCxMPJwglskH6j6jQhCmJGqIr9kR6_iMPng&usqp=CAU'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: false,
                      child: Container(
                        child: Text(
                          'Earn 100 SAR',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.purple,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Provider.of<HomeProvider>(context,listen: false).saveVendor(partner!);

                      },
                      child: Consumer<HomeProvider>(
                        builder:(context, value, child) => CircleAvatar(
                          radius: 15,
                          child: value.isLoading?CircularProgressIndicator():Image.asset(
                            value.savedVendors.any((element) => element.id==partner!.id)||partner!.isSaved
                                ? 'assets/images/save_active.png'
                                : 'assets/images/save_inactive.png',
                          ),
                          backgroundColor:
                              Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                branch==null?'${partner!.name ?? ''}':branch!.name??'',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
