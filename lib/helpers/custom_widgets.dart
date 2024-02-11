import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/screens/commitmetn_details_screen.dart';
import 'package:payback/screens/partner_details_screen.dart';
import 'package:payback/screens/product_details_screen.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;

  bool obscureText = false;
      TextInputType type =  TextInputType.text;

  Widget? icon = null;
  bool editable =true;

  bool isPassword=false;


  CustomTextField(
      {required this.hintText,
      this.obscureText = false,
        this.type =  TextInputType.text,
      this.controller,
      this.icon,
        this.isPassword=false,
        this.editable=true,
      this.maxLines = 1,this.onSaved});

  TextEditingController? controller;
  int maxLines = 1;
  Function? onSaved;
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: widget.maxLines * 48.0,
      child: TextFormField(
        validator: (text){
          if(text!.isEmpty){
            return 'Enter required data';
          }

          if(widget.type==TextInputType.phone&&!text.startsWith('20')){
            return 'Phone should start with 20';
          }
          else
            return null;
        },
        onSaved: (s){
          if(widget.onSaved!=null)
            widget.onSaved!(s);
        },
        readOnly: !widget.editable,
        maxLines: widget.maxLines,
        controller: widget.controller,
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
          contentPadding: EdgeInsets.symmetric(vertical: widget.maxLines*(12), horizontal: 10),
          suffixIcon: IconButton(
            icon: widget.isPassword?Icon(widget.obscureText
                ? Icons.visibility
                : Icons.visibility_off):widget.icon??Icon(null),
            onPressed: () {
              if(widget.isPassword)
              setState(() {
                widget.obscureText = !widget.obscureText;
              });
            },
          ),
        ),
        keyboardType:widget.type,
      ),
    );
  }
}

class TextFieldButton extends StatelessWidget {
  String hinttext;
  Function onTap;
  TextFieldButton({required this.hinttext, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 48.0,
        child: TextField(
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
            suffixIcon: IconButton(
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
      {required this.buttonText, required this.buttonColor, this.onTap,this.textColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if (onTap != null) onTap!();
        },
        style: ElevatedButton.styleFrom(
          primary: buttonColor, // Custom color for the button
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
  final IconData iconData;
  final Color buttonColor;
  final Color iconColor;

  CustomIconButton(
      {required this.buttonText,
      required this.iconData,
      this.buttonColor = Colors.white,
      this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Add your button functionality here
      },
      style: ElevatedButton.styleFrom(
        primary: buttonColor, // Custom color for the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      icon: Icon(
        iconData,
        color: iconColor,
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
  const Commitment({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(CommitmetDetails());
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
                        'Amazon Prime',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  )),
                  Text(
                    '20 SAR',
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
                  value: 20,
                  // divisions: 10,
                  label: '20',
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
                  Text('100% collected',
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

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(ProductDetailsScreen());
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
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    CircleAvatar(
                      radius: 15,
                      child: Image.asset(
                        'assets/images/save_inactive.png',
                      ),
                      backgroundColor: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Nike shop',
                style: TextStyle(
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text('2000 SAR',
                  style: TextStyle(color: Colors.purple, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              Text('Snakers shoe women',
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
  const PartnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(PartnerDetailsScreen());
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
                    image: NetworkImage(
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
                    CircleAvatar(
                      radius: 15,
                      child: Image.asset('assets/images/save_inactive.png'),
                      backgroundColor: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Nike shop',
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
