import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:happsales_crm/models/contact.dart';
import 'package:happsales_crm/view/dashboard/parent.dart';
import 'package:happsales_crm/view/login.dart';
import 'package:happsales_crm/view/menu/items/contacts/views/Details.dart';
import 'package:happsales_crm/view/menu/items/contacts/views/add_contact.dart';
import 'package:happsales_crm/view/menu/items/contacts/views/contact.dart';
import 'package:happsales_crm/view/menu/items/contacts/views/edit_contact.dart';
import 'package:happsales_crm/view/onboarding/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(ScreenUtilInit(

    builder: (BuildContext context, Widget? child) { return GetMaterialApp(

        debugShowCheckedModeBanner: false,


        home: email == null ? SplashScreen() : DashBoardPage()); }, designSize: const Size(375, 812), minTextAdapt: true, splitScreenMode: true,));

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
        return   GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}

