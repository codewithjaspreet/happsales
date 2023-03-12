import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';
import 'IconRow.dart';

class MyAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      content: Container(
        width: 430.w,
        height: 450.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Column(
          children: [
            Text("Add business card" , style: TextStyle(fontSize: 20.sp , fontFamily: "roboto_medium" , fontWeight: FontWeight.w400),),
            Container(
              margin: EdgeInsets.only(top: 50.h),
              child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Container(
                        child: IconRow(title: "Scan", imageUrl: "assets/contacts/scan.png",),
                        width: 126.w,
                        height: 126.h,
                        decoration: BoxDecoration(
                          color: Color(0XFFF5F6F9),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      ),

                      Container(
                        child: IconRow(title: "Camera", imageUrl: "assets/contacts/cam.png",),

                        width: 126.w,
                        height: 126.h,
                        decoration: BoxDecoration(
                          color: Color(0XFFF5F6F9),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      )
                    ],
                  ),

                  Container(

                    margin: EdgeInsets.only(top: 20.h),
                    child: Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children: [
                        Container(
                          child: IconRow(title: "Gallery", imageUrl: "assets/contacts/gallery.png",),

                          width: 126.w,
                          height: 126.h,
                          decoration: BoxDecoration(
                            color: Color(0XFFF5F6F9),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin:   EdgeInsets.only(top: 40.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Center(child: Text("cancel" , style:   TextStyle(color: Colors.white),)),
                          width: 125.w,
                          height:48.h,
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(26.sp),
                            color: Color(0xff8199AC),
                          ),
                        ),
                        Container(
                          child: Center(child: Text("save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold"),)),
                          width: 125.w,
                          height:48.h,
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(26.sp),

                            shape: BoxShape.rectangle,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
