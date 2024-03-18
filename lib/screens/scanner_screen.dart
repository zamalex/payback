import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/checkout_screen.dart';
import 'package:provider/provider.dart';

import '../providers/checkout_provider.dart';
import 'cart_screen.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder:(context, value, child) => Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            MobileScanner(
              overlay:Icon(Icons.fullscreen,color:Colors.white,size: MediaQuery.of(context).size.width),//Image.asset('assets/images/qr.png',color:Colors.white,width: MediaQuery.of(context).size.width-100,height: MediaQuery.of(context).size.width-100,),
          controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
            //facing: CameraFacing.front,
           // torchEnabled: true,
          ),
              onDetect: (BarcodeCapture barcodes) {
              Provider.of<HomeProvider>(context,listen: false).getProducts(location: 'QR',vendorIDs: [1]).then((value){
                Provider.of<CheckoutProvider>(context,listen: false).readCart(Provider.of<HomeProvider>(context,listen: false).products,(value['data']as List).isEmpty?null:value['data'],);

                Get.to(CheckoutScreen());
              });
            },),
           value.isLoading?Center(child: CircularProgressIndicator(),): Positioned(bottom: 0,left:0,right:0,child: Container(
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
      ),
    );
  }
}
