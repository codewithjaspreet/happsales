import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';

import '../widgets/chat_list.dart';
import '../widgets/chat_search_alert.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    
      appBar: CustomAppBar(context),
    
      body: Stack(
        children:[ Container(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Chat' ,style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp
                  ),),
          
                  Row(
                    children: [
                      Container(
                        child: Center(
                          child: Icon(Icons.people  , color: Colors.white,size: 14.sp,),
                        ),
                        width: 22.w,
                        height: 22.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Icon(Icons.group_add_rounded  , color: Colors.white,size: 14.sp,),
                        ),
                        margin: EdgeInsets.only(left: 18.w),
                        width: 22.w,
                        height: 22.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                          showChatAlert(context);
                        },
                        child: Container(
                          child: Center(
                            child: Icon(Icons.search  , color: Colors.white,size: 14.sp,),
                          ),
                          margin: EdgeInsets.only(left: 18.w),
                          width: 22.w,
                          height: 22.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
          
              Container(
                margin: EdgeInsets.only(top: 12.h),
                child: Image.asset('assets/opportunity/banner.png'))
            ,
          
          
              chatList(),
          
            
            ],
          ),
        ),
        bottomDetailsSheet()
        ]
      ),
    );
  }
}

