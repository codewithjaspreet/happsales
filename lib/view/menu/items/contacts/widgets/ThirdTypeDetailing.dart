import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';

class ThirdTypeDetailing extends StatelessWidget {
  ThirdTypeDetailing(
      {Key? key,
        required this.title1,
        required this.subTitle1,
        required this.title2,
        required this.subTitle2})
      : super(key: key);

  final String title1;
  final String subTitle1;
  final String title2;
  final String subTitle2;
  @override
  Widget build(BuildContext context) {


    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(child:
          Container(
            margin: EdgeInsets.only(
              left: 19.w,
              top: 10.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title1,style: TextStyle(
                  fontSize: 13.sp ,
                  color: Color(0xff00A6D6),
                  fontWeight: FontWeight.bold,
                  fontFamily: "roboto_bold",
                ),),
                SizedBox(height: 3.h,),
                Text(subTitle1),
              ],
            ),
          ) ),
          Expanded(child:
          Container(
            margin: EdgeInsets.only(
              left: 18.w,
              top: 10.h
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title2,style:  TextStyle(
                  fontSize: 13.sp ,
                  color: Color(0xff00A6D6),
                  fontWeight: FontWeight.bold,
                  fontFamily: "roboto_bold",
                ),),
                SizedBox(height: 3.h,),
                Text(subTitle2),
              ],
            ),
          ) ),


        ],
      ),
    );
  }
}

