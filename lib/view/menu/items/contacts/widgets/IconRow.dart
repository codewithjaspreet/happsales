import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';
import 'package:flutter/material.dart';
class IconRow extends StatelessWidget {

  IconRow({ required this.imageUrl,required this.title});

  final String title;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          Container(
            child: Center(
              child : Icon(Icons.add,color: Colors.white,),
            ),
            width: 22.w,
            height: 22.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 8.h),
            child: Image.asset(imageUrl),),
          Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(title,style: TextStyle(color: AppColors.primaryColor , fontFamily: "roboto_light" ,fontWeight: FontWeight.w500 ),))
        ],
      ),
    );
  }
}
