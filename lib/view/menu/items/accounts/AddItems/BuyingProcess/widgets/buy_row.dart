import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/BuyingProcess/views/buy_detail.dart';

import '../../../../../../../utils/color.dart';
import '../views/add_buying.dart';

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
          color: Color(0xffE5F6FF),
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
