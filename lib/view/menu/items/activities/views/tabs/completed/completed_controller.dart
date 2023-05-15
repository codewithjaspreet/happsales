import 'package:get/get.dart';

class CompletedController extends GetxController{


  var isOpen = true.obs;


  void toggleDropdown() {
    isOpen.value = !isOpen.value;
  }
}