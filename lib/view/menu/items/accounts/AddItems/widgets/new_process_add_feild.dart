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
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: EdgeInsets.all(12.sp),
          hintText: title,
          hintStyle: TextStyle(
              color: Color(0xff8F9BB3),
              fontWeight: FontWeight.normal,
              fontSize: 15.sp),
        ),
      ),
    );





  }}

