import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';

import '../../../../../utils/color.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Column(
        children: [
          Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text('Attendance' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),)),
    
        ],
      ),

      

    ),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

Row(
  children: [
    TimerWidget(),
    TimerWidget(),
  ],
),
SizedBox(width: 10.w,),
Row(
  children: [
    TimerWidget(),
    TimerWidget(),
  ],
),
SizedBox(width: 10.w,),

Row(
  children: [
    TimerWidget(),
    TimerWidget(),
  ],
),


  ],
)
  ,

Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  Container(
    margin: EdgeInsets.only(top: 20.h),
    child: Text('Hours' , style: TextStyle(fontFamily: 'roboto_medium' , fontSize: 16.sp,color: AppColors.primaryColor),)),
Container(
   margin: EdgeInsets.only(top: 20.h),
    child: Text('Minutes' , style: TextStyle(fontFamily: 'roboto_medium' , fontSize: 16.sp,color: AppColors.primaryColor),)),
Container(
    margin: EdgeInsets.only(top: 20.h),
    child: Text('Seconds' , style: TextStyle(fontFamily: 'roboto_medium' , fontSize: 16.sp,color: AppColors.primaryColor),)),

],)
// TimerCountdown(
//   enableDescriptions: true,
//           format: CountDownTimerFormat.hoursMinutesSeconds,
//           endTime: DateTime.now().add(
//             Duration(
//               hours: 14,
//               minutes: 27,
//               seconds: 34,
//             ),
//           ),
//           onEnd: () {
//             print("Timer finished");
//           },
//         ),
    


    
        ],
      ),



    );
  }
}

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Stack(
            clipBehavior: Clip.none,
            
            children: [
                Positioned(
                 child: Container(
                       margin: EdgeInsets.only(top: 14.h,right: 5.w),
                       child: Image.asset('assets/resources/timerbg.png')),
               ),
                Positioned(
                top: 19.h,
                left: 8.w,
                child: Text('0' , style: TextStyle(fontFamily: 'roboto_regular' , fontSize: 50.sp,color: Colors.white,fontWeight: FontWeight.bold),)),
            
        
            ],   );
  }
}