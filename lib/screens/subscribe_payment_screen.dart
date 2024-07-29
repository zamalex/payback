import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:payback/helpers/functions.dart';
import 'package:payback/screens/main_screen.dart';
import 'package:payback/screens/payment_success_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key, required this.url});

  String url;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  WebViewController? controller;

  int progress = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('progress $progress');
            setState(() {
              this.progress = progress;
            });
          },
          onPageStarted: (String url) {
            print('started: $url');

            if (url.contains('api/success')) {
              setState(() {
                progress = 90;
              });
            }
          },
          onPageFinished: (String url) async {
            //reading response on finish

            if (url.contains('api/success')) {
              final response = await controller?.runJavaScriptReturningResult(
                  "document.documentElement.innerText");
              print('innner: ${response.toString()}');
              if (response.toString().contains('status')) {
                if (response.toString().contains('settled') ||
                    response.toString().contains('pending')) {
                  Get.to(MainScreen());
                  Get.snackbar('Success', 'Subscribed Successfully',
                      colorText: Colors.white, backgroundColor: Colors.green);
                } else if (response.toString().contains('decline')) {
                  Get.to(MainScreen());

                  Get.snackbar('Failed', 'Not successful transaction',
                      colorText: Colors.white, backgroundColor: Colors.red);
                }
              }
            }
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: progress != 100
          ? Center(
              child: Lottie.asset('assets/images/pay.json', width: 200),
            )
          : WebViewWidget(controller: controller!),
    );
  }
}
