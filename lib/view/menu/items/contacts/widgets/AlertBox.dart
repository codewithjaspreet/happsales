import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';
import 'IconRow.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({super.key});

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
                        width: 126.w,
                        height: 126.h,
                        decoration: BoxDecoration(
                          color: const Color(0XFFF5F6F9),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: const IconRow(title: "Scan", imageUrl: "assets/contacts/scan.png",),
                      ),

                      Container(
                        width: 126.w,
                        height: 126.h,
                        decoration: BoxDecoration(
                          color: const Color(0XFFF5F6F9),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: const IconRow(title: "Camera", imageUrl: "assets/contacts/cam.png",),
                      )
                    ],
                  ),

                  Container(

                    margin: EdgeInsets.only(top: 20.h),
                    child: Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 126.w,
                          height: 126.h,
                          decoration: BoxDecoration(
                            color: const Color(0XFFF5F6F9),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: const IconRow(title: "Gallery", imageUrl: "assets/contacts/gallery.png",),
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
                          width: 125.w,
                          height:48.h,
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(26.sp),
                            color: const Color(0xff8199AC),
                          ),
                          child: const Center(child: Text("cancel" , style:   TextStyle(color: Colors.white),)),
                        ),
                        Container(
                          width: 125.w,
                          height:48.h,
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(26.sp),

                            shape: BoxShape.rectangle,
                            color: AppColors.primaryColor,
                          ),
                          child: const Center(child: Text("save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold"),)),
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
