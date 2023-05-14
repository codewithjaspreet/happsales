import 'package:get/get.dart';

class TodayController extends GetxController {
  var isCalender = false.obs;
  var isOpen = true.obs;

  void changeCalender() {
    isCalender.value = !isCalender.value;
  }

  





}