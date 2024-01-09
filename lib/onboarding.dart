import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:payback/login.dart';

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

// OnBoarding content list
final List<OnBoard> demoData = [
  OnBoard(
    image:
        "assets/images/splash_pic_1.png",
    title: "Title 01",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
  OnBoard(
    image:
        "assets/images/splash_pic_2.png",
    title: "Title 02",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
  OnBoard(
    image:
        "assets/images/splash_pic_3.png",
    title: "Title 03",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
  OnBoard(
    image:
        "assets/images/splash_pic_4.png",
    title: "Title 04",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
];

// OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Variables
  late PageController _pageController;
  late PageController _pageController2;
  int _pageIndex = 0;
  Timer? _timer;

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.red,
    Colors.yellow,
  ];
  @override
  void initState() {
    super.initState();
    // Initialize page controller
    _pageController = PageController(initialPage: 0);
    _pageController2 = PageController(initialPage: 0);
    // Automatic scroll behaviour
  }

  @override
  void dispose() {
    // Dispose everything
    _pageController.dispose();
    _timer!.cancel();
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
              itemCount: demoData.length,
              controller: _pageController,
              itemBuilder: (context, index) {
                return Container(
                  //padding: EdgeInsets.all(50),

                   /* child: Image.network(demoData[_pageIndex].image,
                        width: 50,
                        height: 50, fit: BoxFit.contain),*/
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(demoData[_pageIndex].image),fit: BoxFit.cover)));
              }),
        ),
        Transform.rotate(
          angle: -math.pi,
          child: Container(
            decoration: BoxDecoration(image: DecorationImage(image:AssetImage(demoData[_pageIndex].image),fit: BoxFit.cover)),
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
                              demoData.length,
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
                            itemCount: demoData.length,
                            controller: _pageController2,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Column(
                                  children: [
                                    Text(
                                      demoData[_pageIndex].title,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      demoData[_pageIndex].description,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          if (_pageIndex == 3) return;
                          if (_pageIndex < 3) {
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
class OnBoardContent extends StatelessWidget {
  OnBoardContent({
    super.key,
    required this.index,
    required this.image,
    required this.title,
    required this.pageController,
    required this.description,
  });

  String image;
  String title;
  String description;
  PageController pageController;

  int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .55,
            child: Image.network(image,
                height: double.infinity, fit: BoxFit.fitHeight),
            decoration: BoxDecoration(color: Colors.red)),
        Expanded(
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
                      demoData.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: DotIndicator(
                          isActive: index == this.index,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  if (index < 3) {
                    index++;
                  } else {
                    index = 0;
                  }

                  pageController.animateToPage(
                    index,
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
                onTap: () {},
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        ))
      ],
    );
  }
}

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
