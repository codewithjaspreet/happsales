import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/attendance/views/attendance_view.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';

import '../../../../../utils/color.dart';

class AttendanceListing extends StatelessWidget {
  const AttendanceListing({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Column(
        children: [
Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text('Attendance' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),)),
     
        ],
      ),

    ),

    Container(
      margin: EdgeInsets.only(top: 14.h,right: 12.w),
      child: Image.asset('assets/resources/attendancebanner.png'))
    
,
    Container(
      margin: EdgeInsets.only(top: 60.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(AttendanceView());
            
            },
            child: Container(
              width: 100.w,
              height: 100.h,
              child: Image.asset('assets/resources/punch.png')),
          ),

            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Text('Punch In' , style: TextStyle(fontFamily: 'roboto_medium' , fontSize: 16.sp,color: AppColors.primaryColor),)),
        ],
      ),
    )
            ],
      ),
    );
  }
}