import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'DropDown.dart';

class Input2 extends StatelessWidget {
  const Input2({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(left: 16.w , right: 16.w, top: 10.h),
      child: TextFormField(

        decoration: InputDecoration(
         suffixIcon: GestureDetector(

             child: DropDown()

         ),
          hintText: title,
          hintStyle: TextStyle(color: Color(0xff8F9BB3),fontSize: 14.sp,fontWeight: FontWeight.w400,fontFamily: "roboto_regular"),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: Color(0xffB4C6D4),
            ),
          ),

        ),
      ),
    );
  }
}
