import 'package:get/get.dart';

class OpportunityViewController extends GetxController{


   RxBool isAdditionalInfoOpen = false.obs;
    RxBool isOpen = false.obs;
    RxBool seeMore = false.obs;


  void toggleAdditionalInfo(){
    isAdditionalInfoOpen.value = !isAdditionalInfoOpen.value;
  }


  void toggleOpen(){
    isOpen.value = !isOpen.value;
  }

  void toggleSeeMore(){
    seeMore.value = !seeMore.value;
  }
} 