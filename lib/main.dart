import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:happsales_crm/view/dashboard/pages/recommendations.dart';
import 'package:happsales_crm/view/login.dart';
import 'package:happsales_crm/view/onboarding/OnBoarding.dart';
import 'package:happsales_crm/view/onboarding/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, a) {
        return    GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Login(),
        );
      },
    );
  }
}

