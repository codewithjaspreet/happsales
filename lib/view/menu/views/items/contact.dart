import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color.dart';
class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:
        Text("My Contact" , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),

        actions: [
          Container(
            margin:  EdgeInsets.only(right: 16.w),
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff171A63),

            ),
            child: Center(
              child: Icon(Icons.add ,color: Colors.white,),
            ),
          ),
          Container(
            margin:  EdgeInsets.only(right: 10.w),
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor,width: 1),
              // color: Color(0xff171A63),

            ),
            child: Center(
              child: Icon(Icons.more_vert ,color: AppColors.primaryColor,),
            ),
          )
        ],
      ),
      
      body : Container(
        child : Column(
          
          children : [

            Container(
              padding: EdgeInsets.all(28.sp),
              child:             Image.asset("assets/contacts/contact_banner.png"),
            )
          ]
        )
      )
      
      
    );
  }
}
