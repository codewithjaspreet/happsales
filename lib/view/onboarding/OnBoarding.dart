import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/login.dart';

import 'content_model.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<OnBoarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("HappSales" , style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,

      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding:  EdgeInsets.all(40.sp),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[i].image,
                        height: 260.h,
                        width: double.infinity,
                      ),
                      Text(

                        contents[i].title,
                        style: TextStyle(

                          color: const Color(0xff171A63),
                          fontSize: 24.sp,
                          fontFamily: 'roboto_bold',
                          fontWeight: FontWeight.bold,

                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff171A63),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
                  (index) => buildDot(index, context),
            ),
          ),
          Container(
            height: 56.h,

            margin: EdgeInsets.all(40.sp),
            width: 336.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff171A63),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.sp),
                ),
              ),
              child: const Text(
                "Let's Start"
              ),
              onPressed: () {
                Get.to( Login());
              },

            ),
          ),
          Container(width: 134.w,height: 5.h,
            margin: EdgeInsets.only(bottom: 10.h),

            decoration: BoxDecoration(
              color: const Color(0xff8F9BB3),
              borderRadius: BorderRadius.circular(10.sp),
            ),

          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 4.h,
      width: currentIndex == index ? 48.w : 48.w,
      margin: EdgeInsets.only(right: 5.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? const Color(0xff00A6D6)
            : const Color(0xffB4C6D4),
      ),
    );
  }
}