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

      body: SingleChildScrollView(
        child: Column(children: [
          
         Container(
        padding: EdgeInsets.all(12.sp),
        child: Row(
        
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
      
            
            Obx(() =>
            
             todayController.isCalender.value ?
      
             Text('Calender' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),):
      
             Text('Today Activities' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
            ),
            Row( 
              children: [
        
          
            
            //  todayController.isCalender.value ?/÷
            
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
                    child: Obx(() => todayController.isCalender.value? Container(): Center(
                      child: Image.asset('assets/activities/calender.png'),
                    ))
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
      
      
      
           Obx(() =>  todayController.isCalender.value ?  
           
           GestureDetector(
           
        child: SingleChildScrollView(
          child: Column(
            
            children: [
            Container(
              height: 45 .h,
              width: double.infinity,
               decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1)
                  ),
              margin: EdgeInsets.symmetric(vertical: 15.h,horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '05-May-2021 (6)',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: "roboto_bold",
                            fontSize: 14.sp),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        todayController.isOpen.value =
                            !todayController.isOpen.value;
                      },
                      child: Image.asset(todayController.isOpen.value
                          ? "assets/contacts/back.png"
                          : "assets/contacts/up.png")),
                ],
              ),
            ),
            if (todayController.isOpen.value)
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
        
                itemBuilder: (context, index) => Container(
                 
                  padding: EdgeInsets.symmetric(
              
                    horizontal: 10.w,
                    vertical: 10.h
                  ),
                  child: Column(
                    children: [
                
                
                      Container(
                          // margin: EdgeInsets.all(30.sp),
                
                
                color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                
                          Expanded(
                            child: Container(
                              child: Text('Meeting[19725] On 05-May-2021 at 10:00 AM',
                              overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontFamily: "roboto_medium",
                                      fontSize: 14.sp)),
                            ),
                          ),
              
                          SizedBox(width: 10.w,),

                          Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30.w),
                            child: Text('04:15 AM',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: "roboto_medium",
                                    fontSize: 12.sp)),
                          ),
                          SizedBox(height : 10.h),

                          Container(
                            child: Container(
                              height: 30.h,
                              child: Center(child: Text(
                                'Meeting',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "roboto_bold",
                                    fontSize: 12.sp,
                              ))),
                              width: 100.w,
                              decoration: BoxDecoration(

                                color: Colors.blue
                              ),
                              
                            ),
                          )
                
                            ],
                          )
                        
                        ]),
                      ),
              
                     
                    ],
                  ),
                ),
              ),
          ]),
        ),
          )  :  
        
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
        ]
        
        
        ),
        
        
        
        
        ), )
         
        
        
        
        ]),
      ),
    );
  }
}

