import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.sp , right: 16.sp , top: 5.sp),
      child: TextDropdownFormField(
        options: ["Male", "Female"],
        decoration: InputDecoration(
          fillColor: Colors.green,
            border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(8.sp),

            ),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelText: "Gender"),
        dropdownHeight: 120,
      ),
    );
  }
}
