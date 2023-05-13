import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/activities/views/tabs/today/controllers/today_controller.dart';
import 'package:happsales_crm/view/menu/items/contacts/add_contact.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/opportunity/views/opportunity_listing.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../../utils/color.dart';
import '../../../widgets/activities_row.dart';
import '../../activity_view.dart';

class ActivityToday extends StatelessWidget {

  ActivityToday({super.key});

  TodayController todayController = Get.put(TodayController());



  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(children: [
        
       Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(
      
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          
          Text('Today Activities' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
          Row( 
            children: [
      
              GestureDetector(
                onTap: (){

                  todayController.isCalender.value = !todayController.isCalender.value;

                  // Get.to(AddContact());
                },
                child: Container(
                  margin:  EdgeInsets.only(left: 22.w),
                  width: 25.w,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
      
                  ),
                  child:  Center(
                    child: Image.asset('assets/activities/calender.png'),
                  ),
                ),
              ),
              
              GestureDetector(
                onTap: (){
                  Get.to(AddContact());
                },
                child: Container(
                  margin:  EdgeInsets.only(left: 20.w),
                  width: 25.w,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff171A63),
      
                  ),
                  child: const Center(
                    child: Icon(Icons.add ,color: Colors.white,),
                  ),
                ),
              ),
      
              
            ],
          ),
      

      
      
      
        ],
      ),
      
        ),
      
      
     Obx(() => todayController.isCalender.value ?  
     
     TableCalendar(
      weekNumbersVisible: false,
      headerVisible: true ,
      daysOfWeekVisible: false,
      calendarFormat: CalendarFormat.month,
      rowHeight: 32.h,
  firstDay: DateTime.utc(2010, 10, 16),
  lastDay: DateTime.utc(2030, 3, 14),
  focusedDay: DateTime.now(),
):  Image.asset('assets/activities/banner.png')),


      
      Container(
        
        padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 5.w),
        child: Row(
          children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
          child: Text('13-MAY-2023'   , style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: 'roboto_bold',
            fontSize: 20.sp
          ),),
        ),

         Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: Text('You have completed 0 of 0 activities so far!'   , style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: 'roboto_regular',
            fontSize: 12.sp
          ),),
        )
          ],
        ),
        

        Container(
          padding: EdgeInsets.all(10.sp),
          margin: EdgeInsets.only(bottom: 10.h ,left: 10.w),
          child: CircleAvatar(
            radius: 40.r,
            backgroundColor: AppColors.primaryColor,
            child: CircleAvatar(
              radius: 38.r,
              backgroundColor: Colors.white,
              child: Text('0%' , style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: 'roboto_bold',
                fontSize: 24.sp
              ),),
            ),
          ),
          
        )
      ]),
      
      
      
      
      )     , 
       
      
      
      
      ]),
    );
  }
}


