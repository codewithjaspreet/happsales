import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/BuyingProcess/views/buy_detail.dart';

import '../views/add_buying.dart';

class BuyRow extends StatelessWidget {
  const BuyRow(
      {Key? key,
      required this.title,
      required this.date,
      required this.content})
      : super(key: key);

  final String title;
  final String date;
  final String content;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => BuyDetails());
      },
      child: Container(
        width: 336.w,
        height: 86.h,
        decoration: BoxDecoration(
          color: Color(0xffE5F6FF),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 10.h, ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1F2937),
                        )),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1F2937),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                child: AutoSizeText(
                  content,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1F2937),
                  ),
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
