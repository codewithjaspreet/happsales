import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewProcessAddFeild extends StatelessWidget {

  NewProcessAddFeild({required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextField(
        minLines: 2,
        maxLines: 10,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          contentPadding: EdgeInsets.all(15.sp),
          hintText: title,
          hintStyle: TextStyle(
              color: Color(0xff8F9BB3),
              fontWeight: FontWeight.normal,
              fontSize: 14.sp),
        ),
      ),
    );





  }}

