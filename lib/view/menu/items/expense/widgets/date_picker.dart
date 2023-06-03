import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/expense/controllers/expense_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ExpenseDatePicker extends StatelessWidget {
   ExpenseDatePicker({Key? key, required this.labelText}) : super(key: key);

   ExpenseController expenseController = Get.put(ExpenseController());
  final String labelText;

  @override

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal : 18.sp),
        width: 190.h,
        child: TextFormField(

          controller: expenseController.dateController, //editing controller of this TextField
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xffB4C6D4),
              ),
            ),
            labelText:  labelText,
            //label text of field
            labelStyle: const TextStyle(
              color: Color(0xff8F9BB3),
            ),

            floatingLabelStyle: const TextStyle(
              color : Color(0xff00A6D6),
            ),
          ),
          readOnly: true, // when true user cannot edit text
          onTap: () async {
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
    expenseController.dateController.text  = DateFormat('d MMMM').format(DateTime.parse(pickedDate.toString()));
 //set foratted date to TextField value.
              
            } else {
              print("Date is not selected");
            }
          },
        ));
  }
}
