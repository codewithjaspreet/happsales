import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';

Container AmiHeaderRow({required String title}) {
  return Container(
    margin:  EdgeInsets.symmetric(horizontal: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text(title,style: TextStyle(fontFamily: "roboto_bold" , color: AppColors.primaryColor ,fontSize: 20.sp ),),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5.w,top: 8.w,),
              child: Stack(
                children: [
                  Positioned(

                      child: Image.asset("assets/contacts/chat.png")),
                  Positioned(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.w),
                        child: FittedBox(

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Long press Ami \nto fill the details",style: TextStyle(color: Colors.black,fontSize: 8.sp),),
                            )),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 40.w),

                  child: Image.asset("assets/contacts/ami.png"),
                ),
                Container(
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: const BoxDecoration(
                    color: Color(0xffB4C6D4),
                    shape: BoxShape.circle,
                  ),
                  width: 24.w,
                  height: 24.h,
                  child: const Center(
                    child:Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
          ],
        )
      ],
    ),
  );
}
