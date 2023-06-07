import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget AmiVoice(){


return Container(

  decoration: BoxDecoration(
  ),
      padding: EdgeInsets.only(left: 28.w , right: 28.w, top: 10.h),
      child: TextFormField(

        decoration: InputDecoration(
          

          
          hintText:'Chat or give a voice command to Ami!' ,


          hintStyle: TextStyle(
                color: Color(0xffB4C6D4),
                fontSize: 13.sp
            ),
          border: OutlineInputBorder(


            borderRadius: BorderRadius.circular(20.sp),
            borderSide: const BorderSide(

              color: Color(0xffB4C6D4),
            ),

          ),

        ),
      ),
    );
 

}