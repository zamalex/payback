import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  final String hintText;

  bool obscureText = false;

  CustomTextField({required this.hintText,this.obscureText= false});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      child: TextField(

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
          contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 10),
          suffixIcon: IconButton(
            icon: !widget.obscureText?Icon(null):Icon(widget.obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                widget.obscureText = !widget.obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}

class TextFieldButton extends StatelessWidget{

  String hinttext;
  TextFieldButton({required this.hinttext});

  @override
   Widget build(BuildContext context) {
      return Container(
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
            contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 10),
            suffixIcon: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {

              },
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
    const  smallLineHeight = 12;
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
  bool shouldReclip(CustomClipper old) => false;}
class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;

  CustomButton({required this.buttonText, required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          // Add your button functionality here
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
            color: Colors.white,
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

  CustomIconButton({required this.buttonText,required this.iconData, this.buttonColor=Colors.white, this.iconColor=Colors.black});

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
      {required Animation<double> activationAnimation, required Animation<
          double> enableAnimation, required bool isDiscrete, required TextPainter labelPainter, required RenderBox parentBox, required SliderThemeData sliderTheme, required TextDirection textDirection, required double value, required double textScaleFactor, required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final rect = Rect.fromCenter(center: center, width: 6.0,height: 12);

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
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.symmetric(vertical: 10,),
      //height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),gradient: LinearGradient(
        begin: Alignment.center,
        end: Alignment.centerRight,
        colors: [
          Colors.blue.shade900,
          Colors.blue.shade800,
        ],
      ),),
      child: Column(children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.airplanemode_on_rounded, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Amazon Prime',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  )
              ),Text('20 SAR', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)
            ],
          ),
        ),
        Container(

          width: double.maxFinite,
          child: SliderTheme(
            data: SliderThemeData(
                thumbShape: CustomThumbShape()
            ),
            child: Slider(
              activeColor: Colors.teal,

              min: 0.0,
              max: 100.0,
              value: 20,
              // divisions: 10,
              label: '20',
              onChanged: (value) {

              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('100% collected',style: TextStyle(fontSize: 12,color: Colors.white)),
              Text('100% collected',style: TextStyle(fontSize: 12,color: Colors.white)),
            ],
          ),
        )
      ],),
    );
  }
}
