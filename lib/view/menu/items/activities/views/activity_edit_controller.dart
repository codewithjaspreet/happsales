import 'package:get/get.dart';

class ActivityEditController extends GetxController{


  RxBool isOpen = true.obs;

  
  void toggle() {
    isOpen.value = !isOpen.value;
  }
}