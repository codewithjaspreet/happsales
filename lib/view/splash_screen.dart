import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'onboarding/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

   SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 350.h),
                  child: Image.asset(
                      'assets/Icons/Android/1_Splash screen/drawable-hdpi/ic_logo.png'),
                ),
              ),
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      child: Text("© 2021 HappSales App.",
                          style: TextStyle(
                              color: const Color(0xff000000),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400))),
                  Container(
                    width: 134.w,
                    height: 5.h,
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xffB4C6D4),
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  )
                ],
              )
            ],
          );
        },

      ),
    );
  }
}
