import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container Hdivider() {
  return Container(
    margin: EdgeInsets.only(top: 10.h),
    child: Divider(
      thickness: 0.4,
      height: 2.h,
      indent: 20,
      endIndent: 20,
      color: Colors.black,
    ),
  );
}