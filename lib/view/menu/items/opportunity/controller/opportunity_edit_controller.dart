import 'package:get/get.dart';

class OpportunityEditController extends GetxController{


  RxBool isAdditionalInfoOpen = false.obs;
    RxBool isOpen = true.obs;
  RxDouble sliderValue = 0.0.obs;


  void toggleAdditionalInfo(){
    isAdditionalInfoOpen.value = !isAdditionalInfoOpen.value;
  }

  void setSliderValue(double value){
    sliderValue.value = value;
  }

  void toggleOpen(){
    isOpen.value = !isOpen.value;
  }
} 