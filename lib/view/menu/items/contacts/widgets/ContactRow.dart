import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/color.dart';

class ContactRow extends StatelessWidget {

  const ContactRow({required this.firstName ,required this.lastName , required this.employeeDesignation});
  final String firstName;
  final String employeeDesignation;
  final String lastName;

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
                  child: Text(firstName[0] + lastName[0] , style: TextStyle(color: Colors.white , fontSize: 16.sp),),
                ),
              ),
              SizedBox(width: 12.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$firstName $lastName" , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 16.sp),),
                  Text(employeeDesignation , style: TextStyle(fontFamily: 'roboto_regular' , fontSize: 12.sp),),
                ],
              )
            ],
          ),

        ],
      ),
    );
  }
}
