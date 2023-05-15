import 'package:get/get.dart';


class ActivityViewController extends GetxController{


   RxBool isOpen = true.obs;
   RxBool seeMore = false.obs;


  void toggle(){

    isOpen.value = !isOpen.value;
  }

  void toggleSeeMore(){

    seeMore.value = !seeMore.value;
  }
}