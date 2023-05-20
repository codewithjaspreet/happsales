import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';

import '../../../../../../../../utils/color.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

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
            child: Text('My Profile' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),)),


            
        ],
      ),
      

    ),

    Container(

      height: 160.h,
      width: 160.w,
      margin: EdgeInsets.only(top: 14.h,right: 12.w),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.sp),
        color: Colors.blue.withOpacity(0.2),
        image: DecorationImage(
          image: AssetImage('assets/settings/add_2.png'),
          fit: BoxFit.cover
        )
      ),
    ),

    Column(
      children: [
         Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
            child: Text('Deepak' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),)),

         Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
            child: Text('Advisor' , style: TextStyle(fontFamily: 'roboto_regular' , fontSize: 18.sp,color: AppColors.primaryColor),)),

         Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 6.h),
            child: Text('HappSales Private Limited Dev' , style: TextStyle(fontFamily: 'roboto_medium' , fontSize: 15.sp,color: AppColors.themeColor),)),


      ],
    ),
    SizedBox(height: 15.h,),

    Input(title: 'Mobile Number',),
        SizedBox(height: 12.h,),

    Input(title: 'Email Address',),
        SizedBox(height: 12.h,),

    Input(title: 'Reports To'),

    Container(
      margin: EdgeInsets.only(top: 25.h),
      width: 230.w,
      height: 50.h,
      child: Container(
        padding: EdgeInsets.all(10.sp),
        child: Center(child: Text('Reset Password',style: TextStyle(
      
          color: Colors.white,
          fontFamily: 'roboto_bold',
          fontSize: 16.sp
        ),)),
      ),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(40.sp),
        color: AppColors.primaryColor
      
      ),
    )
        ],
      ),
    );
  }
}