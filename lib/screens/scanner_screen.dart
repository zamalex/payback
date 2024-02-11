import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:payback/helpers/colors.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          MobileScanner(onDetect: (BarcodeCapture barcodes) {  },),
          Positioned(bottom: 0,left:0,right:0,child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color:kBackgroundColor,borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Payback in-store partner',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(height: 10,)
              ,Text('If you are at one of the stores that are Payback partners, you can scan Payback QR code in store to get cashback on certain products',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),)
            ],),
          ),)
        ],),
      ),
    );
  }
}
