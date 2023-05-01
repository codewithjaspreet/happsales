import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'floating.dart';

Widget floatingCollapsed(){
  return Stack(
      clipBehavior: Clip.none,


      children :[

        Positioned(
          top: -5.h,
          left: 160.w,
          child: GestureDetector(
            onTap: () {
              floatingPanel();
            },
            child:
            Container(
              width: 60.w,
              height: 60.w,
              decoration: const BoxDecoration(

                shape: BoxShape.circle,
              ),
              child: Image.asset("assets/ami/ami_logo.png"),
            ),


          ),
        ),
        Positioned(
          left: 125.w,
          top: 76.h,
          child: Container(
            child: Text("Powered by HappSales",style: TextStyle(
                fontFamily: "roboto_regular",
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color:const Color(0xffB4C6D4)
            ),),
          ),)



      ]
  );
}