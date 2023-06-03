import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';
import 'package:http/http.dart';

import '../widgets/chat_list.dart';
import '../widgets/chat_search_alert.dart';
import '../widgets/single_user_alert.dart';
import 'new_group_chat.dart';

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
                  Container(
                  margin: EdgeInsets.only(left: 8.w),
                    child: Text('Chat' ,style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp
                    ),),
                  ),
          
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showSingleUser(context);
                        },
                        child: Container(
                          child: Center(
                            child: Image.asset('assets/chats/add_user.png')
                          ),
                          width: 22.w,
                          height: 22.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GroupChat()),
                          );
                        },
                        child: Container(
                          child: Center(
                            child:Image.asset('assets/group.png'),
                            
                          
                          ),
                          margin: EdgeInsets.only(left: 18.w),
                          width: 22.w,
                          height: 22.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
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
                child: Image.asset('assets/chats/chat_header.png'))
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

