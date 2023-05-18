import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/widgets/new_process_add_feild.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';

import '../../../../../utils/color.dart';

class ShareResource extends StatelessWidget {
  const ShareResource({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: SingleChildScrollView(
        child: Column(children: [
      
         Container(
        padding: EdgeInsets.all(12.sp),
        child: Row(
      
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5.w),
              child: Text('Share Resource' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),)),
           
          ]
        ),
          ),
      
      
           Input(title: 'From'),
            Input(title: 'To Emails Comma Seperated'),
          Input(title: 'Cc Emails [Comma Seperated]'),
          Input(title: 'Subject'),
          SizedBox(height: 20.h,),
          NewProcessAddFeild(title: 'Mail'),
           Container(
              margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 210.h),
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
                    child: Center(child: Text("Cancel" , style:   TextStyle(color: Colors.white,fontSize: 18.sp),)),
                  ),
                  Container(
                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),
      
                      shape: BoxShape.rectangle,
                      color: AppColors.primaryColor,
                    ),
                    child: Center(child: Text("Save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold",fontSize: 18.sp),)),
                  )
                ],
              ),
            )
      
      
      
        ]),
      ),
    );
  }
}