import 'package:get/get.dart';

class ExpenseController extends GetxController{

  RxBool isOpen  = true.obs;

  RxBool additional = true.obs;


  RxBool expenseDetails = true.obs;

  RxBool expenseEntry = true.obs;

  



  void toggleOpen(){
    isOpen.value = !isOpen.value;
  }

  void toggleAdditional(){
    additional.value = !additional.value;
  }


  void toggleExpenseDetails(){
    expenseDetails.value = !expenseDetails.value;
  }
}