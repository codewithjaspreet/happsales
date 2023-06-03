import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';

chatList() {

  int generateRandomColorInt() {
    Random random =  Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    int color = (r << 16) + (g << 8) + b;
    return color;
  }

  // ContactViewModel contactController = Get.put(ContactViewModel());
  return  Expanded(
      child:  ListView.builder(
        padding: EdgeInsets.all(12.sp),

        itemCount:3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){

              // print("THE ID IS${contactController.contacts[index].contactID}");
              // Get.to(() =>,));
            },
            child: Container(
              margin: EdgeInsets.only(top : 12.sp),
              height: 90.h,
                width: 337.w,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10.r),

              ),

              child: Row(
                children: [
                  Image.asset('assets/chats/chat_individual.png'),

                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        margin: EdgeInsets.only(left : 16.sp),
                        child: Text('Renuka'.toString(),style:  TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold
                        ),),
                      ),Container(
                        margin: EdgeInsets.only(left : 16.sp,top: 2.sp,),
                        child: Text('Inside Sales'.toString(),
                            style: const TextStyle(
                                color: AppColors.primaryColor
                            )),
                      ),

                      
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ));
}