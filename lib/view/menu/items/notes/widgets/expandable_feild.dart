import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';

class MyExpandAlert extends StatelessWidget {
  const MyExpandAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 30.h),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/accounts/close.png'),
          

          Container(
            width: 22.w,
            height: 22.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue
            )
      ,
            child: const Center(child: Icon(
              Icons.done,
              color: Colors.white,
            )),
          ),
        
        ],
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
      ),
      content: Container(
        width: 260.w,
        height: 504.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                height: 500.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),

                  borderRadius: BorderRadius.circular(12.sp),
                
                ),
                child: TextFormField(
                  minLines: 2,
          maxLines: 40,
                  
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
                    border: InputBorder.none,
                  ),
                ),
              )




            ],
          ),
        )
      ),

    );
  }
}