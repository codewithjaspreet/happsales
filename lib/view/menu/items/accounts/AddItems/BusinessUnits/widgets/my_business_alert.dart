import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyBusinessAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      content: Container(
        width: 430.w,
        height: 450.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Column(
          children: [
            Text("Add business card" , style: TextStyle(fontSize: 20.sp , fontFamily: "roboto_medium" , fontWeight: FontWeight.w400),),
            Container(
              margin: EdgeInsets.only(top: 50.h),
              child: Column(

                children: [





                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
