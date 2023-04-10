import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DatePickerFeild extends StatefulWidget {
  // const DatePickerFeild({Key? key}) : super(key: key);

  @override
  State<DatePickerFeild> createState() => _DatePickerFeildState();

}

class _DatePickerFeildState extends State<DatePickerFeild> {

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(16.sp),
            margin: EdgeInsets.only(top: 10.h),
            height:90.h,
            child:TextFormField(
              controller: dateController, //editing controller of this TextField
              decoration:  InputDecoration(
               border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                      borderSide: BorderSide(
                        color: Color(0xffB4C6D4),
                      ),
                    ),
                  suffixIcon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Enter Date" //label text of field
              ),
              readOnly: true,  // when true user cannot edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101)
                );

                if(pickedDate != null ){
                  print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                  print(formattedDate); //formatted date output using intl package =>  2022-07-04
                  //You can format date as per your need

                  setState(() {
                    dateController.text = formattedDate; //set foratted date to TextField value.
                  });
                }else{
                  print("Date is not selected");
                }
              },
            ));
  }
}
