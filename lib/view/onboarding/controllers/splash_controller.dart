import 'dart:async';

import 'package:get/get.dart';
import 'package:happsales_crm/view/onboarding/OnBoarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // Check if the user has seen the boarding screens before

    // Navigate to the appropriate screen
    Timer(const Duration(seconds: 3), () {
      checkFirstSeen();
    });
  }



  Future<void> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool('seen') ?? false;

    if (seen) {
      // If the user has already seen the onboarding screen, go to the login page
      Get.off(Login());
    } else {
      // If the user has not seen the onboarding screen, go to the onboarding screen
      await prefs.setBool('seen', true);
      Get.off(OnBoarding());
    }
  }
}
