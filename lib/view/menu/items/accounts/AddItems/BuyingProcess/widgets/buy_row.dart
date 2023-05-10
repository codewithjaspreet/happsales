import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../../utils/color.dart';

class BuyRow extends StatelessWidget {
  const BuyRow(
      {Key? key,
      required this.title,
      required this.date,
        required this.route,
      required this.content})
      : super(key: key);

  final String title;
  final String date;
  final String content;
  final Widget route;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => route);
      },
      child: Container(
        width: 336.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: const Color(0xffE5F6FF),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(

                    title,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),),
                  Expanded(
                    flex: 0,
                    child: Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(

                    content,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                    ),
                  ),),

                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
