import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget AmiRow(String imageUrl , String title ){


  return Container(
    margin: EdgeInsets.only(top: 12.h),
    width: 323.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: const Color(0xff171A63),
      borderRadius: BorderRadius.circular(24.sp),
    ),
    child: Container(

      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imageUrl),
              Container(
                margin: EdgeInsets.only(left: 8.w),
                child: Text(title,style: TextStyle(
                    fontFamily: 'roboto_medium',
                    fontSize: 14.sp
                    ,
                    color: Colors.white,
                    fontWeight: FontWeight.w400

                ),),
              ),

            ],
          ),
          Container(
            child: Image.asset("assets/ami/forward.png"),
          )
        ],
      ),
    ),
  );

}
