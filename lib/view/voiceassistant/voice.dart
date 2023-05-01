import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget AmiVoice(){

  return Container(

    width: 323.w,
    height: 50.h,
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xffB4C6D4),
        width: 1,
      ),
      color:  Colors.white,
      borderRadius: BorderRadius.circular(24.sp),
    ),

    child: Container(
      margin : EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Chat or give a voice command to Ami!",style: TextStyle(
              color: Color(0xffB4C6D4)
          ),),

          SizedBox(
              width: 22.h,
              height: 22.h,
              child: Image.asset("assets/ami/voice.png"))
        ],
      ),
    ),
  );

}