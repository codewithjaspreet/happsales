import 'package:get/get.dart';

class ActivityEditController extends GetxController{


  RxBool isOpen = true.obs;
  RxBool isAdditionalInfoOpen = true.obs;

  
  void toggle() {
    isOpen.value = !isOpen.value;
  }
  void toggleAdditionalInfo() {
    isAdditionalInfoOpen.value = !isAdditionalInfoOpen.value;
  }
}