import 'package:get/get.dart';

class CalenderController extends GetxController{

  var isOpen = true.obs;


  void toggleOpen(){

    isOpen.value = !isOpen.value;
  }
}