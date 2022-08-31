import 'package:flutter/material.dart';
import 'package:mnadeby/screens/layout_screen/LayoutScreen.dart';
import 'package:mnadeby/shared/cache_helper/cache_helper.dart';

class OnBoardingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: 0);
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/manage_orders.png",
                      height: 500,
                      width: 500,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 10,
                      child: Text(
                        "ادارة اوردرات",
                        style: TextStyle(
                            color: Color(0xff34a853),
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Center(
                    child: Text(
                      "تقدر تضيف اوردرات بالبيانات بتاعتها زي العنوان و رقم التليفون و تعرف تعدل على البيانات و تعرف حالة الاوردر وصل ولا لا",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Color(0xff34a853),
                                shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                        ],
                      ),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.linear);
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Location_tracking.png",
                      height: 500,
                      width: 500,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 10,
                      child: Text(
                        "تتبع مندوبك",
                        style: TextStyle(
                            color: Color(0xff34a853),
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Center(
                    child: Text(
                      "تقدر تتابع مناديبك و تعرف اماكنهم و تحركاتهم من على الخريطه ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Color(0xff34a853),
                                shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                        ],
                      ),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.linear);
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 80,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Money_income.png",
                      height: 400,
                      width: 400,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: -10,
                      child: Text(
                        "تحصيلات اليوم",
                        style: TextStyle(
                            color: Color(0xff34a853),
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Center(
                    child: Text(
                      "هتقدر تعرف اجمالي تحصيلات اليوم و هتعرف تحصيل كل مندوب كام",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Color(0xff34a853),
                                shape: BoxShape.circle),
                          ),
                        ],
                      ),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            saveOnBoardingVisited();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return LayoutScreen();
                            }));
                          },
                          child: Text(
                            "Go",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void saveOnBoardingVisited(){
  CacheHelper.setData(key: "boarding_visited", value: true);
}
