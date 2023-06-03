import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseController extends GetxController{


  RxBool isOpen  = true.obs;
  RxBool additional = true.obs;
  RxBool isEditDetailOpen = true.obs;
  RxBool expenseDetails = true.obs;
  RxBool expenseEntry = true.obs;
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  
   

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dateController.text  = DateFormat('d MMMM').format(DateTime.parse(selectedDate.toString()));

  }
  
  
  void pickDate(BuildContext context) async {
   DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), //get today's date
                firstDate: DateTime(
                    2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101)
                );

            if (pickedDate != null) {
              print(
                  pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
              String formattedDate = DateFormat('yyyy-MM-dd').format(
                  pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
              print(
                  formattedDate); //formatted date output using intl package =>  2022-07-04
              //You can format date as per your need

                dateController.text =
                    formattedDate; //set foratted date to TextField value.
            } else {
              print("Date is not selected");
            }
  }
  



  void toggleOpen(){
    isOpen.value = !isOpen.value;
  }

  void toggleAdditional(){
    additional.value = !additional.value;
  }


  void toggleExpenseDetails(){
    expenseDetails.value = !expenseDetails.value;
  }

  void toggleExpenseEntry(){
    expenseEntry.value = !expenseEntry.value;
  }

  void toggleEditDetailOpen(){
    isEditDetailOpen.value = !isEditDetailOpen.value;
  }
}