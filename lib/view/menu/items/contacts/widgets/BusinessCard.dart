import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      width: 336.w,
      height: 216.h,
      decoration: BoxDecoration(
        color: const Color(0xffF5F6F9),
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Container(
              child: Center(
                child : Icon(Icons.add,color: Colors.white,),
              ),
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(child: Image.asset("assets/contacts/add.png"),),
            Container(
              child: Text("add business card" , style: TextStyle(fontWeight: FontWeight.w500 , fontFamily: "roboto_medium" , fontSize: 18.sp),),


            )


          ],
        ),
      ),
    );
  }
}

