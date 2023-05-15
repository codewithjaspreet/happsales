import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/activities/views/calender/calender_controller.dart';
import 'package:happsales_crm/view/menu/items/activities/views/tabs/today/controllers/today_controller.dart';
import 'package:happsales_crm/view/menu/items/contacts/add_contact.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/opportunity/views/opportunity_listing.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../../utils/color.dart';

class CalenderView extends StatelessWidget {

  CalenderView({super.key});

  CalenderController calenderController = Get.put(CalenderController());



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(context),

      body: SingleChildScrollView(
        child: Column(children: [
          
         Container(
        padding: EdgeInsets.all(16.sp),
        child: Row(
        
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
      
            
           
            
             
      
             Text('Calender' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor)),

      
            
            Row( 
              children: [
        
          
            
            //  todayController.isCalender.value ?/÷
            
              
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
        
        
           
           
           TableCalendar(
        weekNumbersVisible: false,
        headerVisible: true ,
        daysOfWeekVisible: false,
        calendarFormat: CalendarFormat.month,
        rowHeight: 32.h,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      ),
      
      
      
           
           
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
              margin: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
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
                  Obx(() =>  calenderController.isOpen.value ? 
                  GestureDetector(

                      onTap: () {

                        calenderController.isOpen.value =
                            !calenderController.isOpen.value;
                      },
                      child: Image.asset(calenderController.isOpen.value
                          
                          
                          ? "assets/contacts/back.png"
                          : "assets/contacts/up.png")
                          
                          )  
                          
                          : Container(),
                          
                  )
                ],
              ),
            ),
            if (calenderController.isOpen.value)
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
          ), 
        
          
      
        
        
        
        ]),
      ),
    );
  }
}

