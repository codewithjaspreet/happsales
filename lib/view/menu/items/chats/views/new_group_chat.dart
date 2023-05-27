import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/ToggleButtonRow.dart';

import '../../../menu.dart';
class GroupChat extends StatelessWidget {
  const GroupChat({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Text(
      "HappSales",
      style: TextStyle(
          color: Colors.white, fontSize: 16.sp, fontFamily: 'roboto_bold'),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: [
      IconButton(
        onPressed: () {
          Get.to(() => const Menu());
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
    ],
  ),
      backgroundColor: AppColors.primaryColor,

      body: Stack(
        children:[ Container(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            
            children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.blue.withOpacity(0.9),
                  child: Icon(Icons.people , color: AppColors.primaryColor,size: 28.sp,),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.h,left: 10.w),
                  child: Text('New Group',style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'roboto_bold'
                  ),),
                )
                
              ],
            ),

           


            
           

          ],),
        ),

        Container(
          child: Container(
            padding: EdgeInsets.only(top : 12.sp),
            child: Column(
              
              children: [
          
              Input(title: 'Group Name*'),
              Input(title: 'Description*'),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 18.w,vertical: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
              
                    Text('Group Members',style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'roboto_bold',
                      fontSize: 16.sp
                    
                    ),),
                    Container(
                          child: Center(
                            child: Icon(Icons.people  , color: Colors.white,size: 14.sp,),
                          ),
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                  ],
                ),
              ),

              ToggleButtonRow(title: 'Is Active', isAlreadyActive: true),

              Expanded(
                child:  Container(
              margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 280.h),
                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),
                      color: const Color(0xff8199AC),
                    ),
                    child: Center(child: Text("Cancel" , style:   TextStyle(color: Colors.white,fontSize: 18.sp),)),
                  ),
                  Container(
                       margin: EdgeInsets.only(top: 280.h),

                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),

                      shape: BoxShape.rectangle,
                      color: AppColors.primaryColor,
                    ),
                    child: Center(child: Text("Save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold"
                    ,fontSize: 18.sp
                    ),)),
                  )
                ],
              ),
            ),
              )
            ]
            
            ),
          ),
          margin: EdgeInsets.only(top: 85.h),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)),
          ),
        )
        ]
      ),
    );
  }
}