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