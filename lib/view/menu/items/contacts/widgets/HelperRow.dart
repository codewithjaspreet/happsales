import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../utils/color.dart';
import '../views/add_contact.dart';

class HelperRow extends StatelessWidget {

  const HelperRow({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(AddContact());
                },
                child: Container(
                  margin:  EdgeInsets.only(right: 16.w),
                  width: 30.w,
                  height: 30.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff171A63),

                  ),
                  child: const Center(
                    child: Icon(Icons.add ,color: Colors.white,),
                  ),
                ),
              ),
              Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColor,width: 1),
                  // color: Color(0xff171A63),

                ),
                child: const Center(
                  child: Icon(Icons.more_vert ,color: AppColors.primaryColor,),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
