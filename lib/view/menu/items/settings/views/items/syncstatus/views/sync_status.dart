import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';

import '../../../../../../../../utils/color.dart';

class SyncStatus extends StatelessWidget {
  const SyncStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

          Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5.w),
            child: Text('Sync Status' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),)),
          Row(
            children: [
              GestureDetector(
                
                child: Container(
                  margin:  EdgeInsets.only(right: 7.w),
                  width: 20.w,
                  height: 20.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,

                  ),
                  
                ),
              ),
              
            ],
          ),
        ],
      ),
    ),

    Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    
          Container(
            margin: EdgeInsets.only(bottom: 3.h),
            child: Text('Down Sync Status',style: TextStyle(
              color: AppColors.themeColor,
              fontFamily: 'roboto_medium',
            ),),
          ),
           Text('120 of 121',style: TextStyle(
              color: AppColors.primaryColor,
            fontSize: 16.sp,
            fontFamily: 'roboto_regular',
          ),),
           Text('Unit - 1/1',style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16.sp,
            fontFamily: 'roboto_regular',
          ),)
        ],
      ),
    ),

      Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    
          Container(
            margin: EdgeInsets.only(bottom: 3.h),
            child: Text('Up Sync Status',style: TextStyle(
              color: AppColors.themeColor,
              fontFamily: 'roboto_medium',
            ),),
          ),
           Text('Sync Completed',style: TextStyle(
              color: AppColors.primaryColor,
            fontSize: 16.sp,
            fontFamily: 'roboto_regular',
          ),),
           Text('Last Sync: 24-May-2023 05:22',style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16.sp,
            fontFamily: 'roboto_regular',
          ),)
        ],
      ),

      
    ),
    
      Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    
          Container(
            margin: EdgeInsets.only(bottom: 3.h),
            child: Text('Chat Sync Status',style: TextStyle(
              color: AppColors.themeColor,
              fontFamily: 'roboto_medium',
            ),),
          ),
           Text('-',style: TextStyle(
              color: AppColors.primaryColor,
            fontSize: 16.sp,
            fontFamily: 'roboto_regular',
          ),),
           
        ],
      ),

      
    ),


          ],),
          bottomDetailsSheet()
        ],
      ),

    );
  }
}