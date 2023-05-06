import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/notes/views/edit_notes.dart';

import '../../accounts/AddItems/BuyingProcess/widgets/buy_sec_row.dart';

class ViewnNotes extends StatelessWidget {
  const ViewnNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Column(
        children: [

          Container(
            padding: EdgeInsets.symmetric(horizontal : 20.w,vertical: 5.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note Code',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00A6D6),



                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'HAPPSALES-ACCMP-00000000074',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(

                  onTap: () {
                    Get.to(const EditNotes());
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    width: 25.w,
                    height: 25.h,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/contacts/edit.png'),
                  ),
                )
              ],
            ),
          ),
          const BuySecondRow(
            compTitle: "Note Content",
            compSubTitle: "new test activity cell",
          ),

          const BuySecondRow(
            compTitle: "Note Date",
            compSubTitle: "07 Apr 2023",
          ),
     Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w , vertical:14.h
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activity Title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff00A6D6),


                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                  'Call[19725] On 07-Apr-2023 At 03:43',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.sp,
                  ),
                ),
                Icon(Icons.arrow_forward_ios,size: 18.sp,color: AppColors.primaryColor,)
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    ),
          const BuySecondRow(compTitle: 'Tags', compSubTitle: '-'),

          Container(
            padding: EdgeInsets.all(20.sp),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created By',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00A6D6),


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'deepak',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modified By',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00A6D6),


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created On',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00A6D6),


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '25 Mar 2023',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modified On',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00A6D6),


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

        ],
      ),





    );
  }
}
