import 'package:get/get.dart';

class OpportunityEditController extends GetxController{


  RxBool isAdditionalInfoOpen = false.obs;
    RxBool isOpen = true.obs;
  RxDouble sliderValue = 55.0.obs;
  RxBool isAlreadyActive= false.obs;


  void toggleAdditionalInfo(){
    isAdditionalInfoOpen.value = !isAdditionalInfoOpen.value;
  }

  void setSliderValue(double value){
    sliderValue.value = value;
  }

  void toggleOpen(){
    isOpen.value = !isOpen.value;
  }

  void toggleActive(){
    isAlreadyActive.value = !isAlreadyActive.value;
  }
} 