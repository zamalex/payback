import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/screens/register.dart';
import 'dart:math' as math;


import '../model/onboarding_response.dart';
import 'login.dart';

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}



// OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({super.key,required this.data});

  List<Data> data = [];

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Variables
  late PageController _pageController;
  late PageController _pageController2;
  int _pageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    print('lengthn ${(widget.data as List<Data>).first.title}');

    // Initialize page controller
    _pageController = PageController(initialPage: 0);
    _pageController2 = PageController(initialPage: 0);
    // Automatic scroll behaviour
  }

  @override
  void dispose() {
    // Dispose everything
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .55,
          child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                  print("img index ${index}");

                  _pageController2.animateToPage(
                    _pageIndex,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeIn,
                  );
                });
              },
              itemCount: widget.data.length,
              controller: _pageController,
              itemBuilder: (context, index) {
                return Container(
                  //padding: EdgeInsets.all(50),

                   /* child: Image.network(widget.data[_pageIndex].image,
                        width: 50,
                        height: 50, fit: BoxFit.contain),*/
                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.data[_pageIndex].image!),fit: BoxFit.cover)));
              }),
        ),
        Transform.rotate(
          angle: -math.pi,
          child: Container(
            decoration: BoxDecoration(image: DecorationImage(image:NetworkImage(widget.data[_pageIndex].image!),fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .45,
              child: Transform.rotate(
                angle: -math.pi,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              widget.data.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: DotIndicator(
                                  isActive: index == this._pageIndex,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                _pageIndex = index;
                                print("txt index ${index}");

                                _pageController.animateToPage(
                                  _pageIndex,
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeIn,
                                );
                              });
                            },
                            itemCount: widget.data.length,
                            controller: _pageController2,
                            itemBuilder: (context, index) {
                              return Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.data[_pageIndex].title!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        widget.data[_pageIndex].description??'',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          if (_pageIndex == widget.data.length-1) Get.to(LoginScreen());
                          if (_pageIndex < widget.data.length-1) {
                            _pageIndex++;
                          } else {
                            _pageIndex = 0;
                          }
                          print("clicked page ibdex ${_pageIndex}");
                          _pageController.animateToPage(
                            _pageIndex,
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeIn,
                          );

                          _pageController2.animateToPage(
                            _pageIndex,
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontFamily: "HappyMonkey",
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
                        },
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                ),
              )),
        )
      ],
    ));
  }
}

// OnBoarding area widget

// Dot indicator widget
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 40 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        //border: isActive ? null : Border.all(color: Colors.green),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
