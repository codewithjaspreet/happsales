import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/color.dart';

class ContactRow extends StatelessWidget {

  const ContactRow({super.key, required this.firstName ,required this.lastName , required this.account, });
  final String firstName;
  final String lastName;
  final String account;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      width: 337.w,
      height: 90.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Text("hello" , style: TextStyle(color: Colors.white , fontSize: 16.sp),),
                ),
              ),
              SizedBox(width: 12.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(firstName[0] + lastName[0] , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 16.sp),),
                  Text(account , style: TextStyle(fontFamily: 'roboto_regular' , fontSize: 12.sp),),
                ],
              )
            ],
          ),

        ],
      ),
    );
  }
}
