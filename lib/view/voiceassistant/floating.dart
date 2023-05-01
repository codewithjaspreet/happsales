import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/voiceassistant/voice.dart';

import 'ami_row.dart';

Widget floatingPanel(){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(24.sp)),

    ),
    // margin: const EdgeInsets.all(24.0),
    child: Column(
      children: [
        Expanded(
          child: Container(
              margin: EdgeInsets.only(top: 52.h),
              child:    Column(
                children: [
                  Container(
                    child: Text("Hi I'm Ami, how can I help you?",style: TextStyle(
                        fontFamily: 'roboto_bold',
                        fontSize: 18.sp
                        ,
                        fontWeight: FontWeight.w500

                    ),),
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 22.h),

                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AmiRow("assets/ami/building.png" , "I want to know about my company")
                        ,AmiRow("assets/ami/people.png" , "Want to create a contact?")
                        ,AmiRow("assets/ami/money.png" , "Want to create an opportunity?")
                        ,AmiRow("assets/ami/calender.png" , "Want to create an activity?")

                      ],
                    ),

                  ),

                  Container(

                      margin: EdgeInsets.only(top: 20.h),

                      child: AmiVoice()),

                  Container(
                    margin: EdgeInsets.only(top: 8.h),
                    child: Text("Powered by HappSales",style: TextStyle(
                        fontFamily: "roboto_regular",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color:const Color(0xffB4C6D4)
                    ),),
                  )
                ],
              )
          ),
        ),

      ],
    ),
  );
}
