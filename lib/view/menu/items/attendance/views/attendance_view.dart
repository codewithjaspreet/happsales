import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';

import '../../../../../utils/color.dart';
import '../../opportunity/views/opportunity_view.dart';

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

],),
GestureDetector(
            onTap: () {
              Get.to(AttendanceView());
            
            },
            child: Container(
              margin: EdgeInsets.only(top: 40.h),
              width: 100.w,
              height: 100.h,
              child: Image.asset('assets/resources/punch.png')),
          ),
          Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Text('Punch Out' , style: TextStyle(fontFamily: 'roboto_medium' , fontSize: 16.sp,color: AppColors.primaryColor),)),
    

    Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.h,left: 20.w),
          child: Row(
            children: [
        
              Text('18-May-2021' , style: TextStyle(fontFamily: 'roboto_medium' , fontSize: 16.sp,color: AppColors.primaryColor),),
            ],
          ),
        ),
        // buildOpportunityList()

        Container(
          child: Row(children: [

            Container(
              margin: EdgeInsets.all(14.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Punch-In',style: TextStyle(
                    fontFamily: 'roboto_medium',
                    fontSize: 13.sp,
                    color: AppColors.primaryColor
                  
                  ),),
                   Text('07:19 Pm',style: TextStyle(
                    fontFamily: 'roboto_medium',
                    fontSize: 16.sp,
                    color: AppColors.primaryColor
                  
                  ),)
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal :20.sp,vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Punch-In-Location',style: TextStyle(
                      fontFamily: 'roboto_medium',
                      fontSize: 13.sp,
                      color: AppColors.primaryColor
                    
                    ),),
                    SizedBox(height: 3.h,),
                     Text('City of Westminster',style: TextStyle(
                      fontFamily: 'roboto_bold',
                      fontSize: 12.sp,
                      color: AppColors.primaryColor
                    
                    ),),
                    Text('Picaddily London, United',style: TextStyle(
                      fontFamily: 'roboto_bold',
                      fontSize: 12.sp,
                      color: AppColors.primaryColor
                    
                    ),),
                    Text('Kingdom,W1J',style: TextStyle(
                      fontFamily: 'roboto_bold',
                      fontSize: 12.sp,
                      color: AppColors.primaryColor
                    
                    ),)
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal :20.sp,vertical: 10.h),
              child: Column(
                
                children: [
                  Container(
                    child: Image.asset('assets/resources/formedit.png'),
                  ),
                ],
              ),
            )
          ]),
          margin: EdgeInsets.symmetric(horizontal: 10.w  , vertical: 10.h),
          width: 337.w,
          height: 90.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10.r),
          
          ),
        ),
        Container(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            Container(
              margin: EdgeInsets.all(14.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Punch-In',style: TextStyle(
                    fontFamily: 'roboto_regular',
                    fontSize: 13.sp,
                    color: AppColors.primaryColor
                  
                  ),),
                   
                   
                ],
              ),
            ),
            
            Container(
              margin: EdgeInsets.all(14.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Punch-Out-Location',style: TextStyle(
                    fontFamily: 'roboto_regular',
                    fontSize: 13.sp,
                    color: AppColors.primaryColor
                  
                  ),),
                   
                   
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal :20.sp,vertical: 10.h),
              child: Column(
                
                children: [
                  Container(
                    child: Image.asset('assets/resources/formedit.png'),
                  ),
                ],
              ),
            )
          ]),
          margin: EdgeInsets.symmetric(horizontal: 10.w  , vertical: 2.h),
          width: 337.w,
          height: 80.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10.r),
          
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w , vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
        
              Text('Time Difference' ,style: TextStyle(
                fontFamily: 'roboto_medium',
                fontSize: 16.sp,
                color: AppColors.primaryColor
              
              ),),
               Text('Time Difference' ,style: TextStyle(
                fontFamily: 'roboto_medium',
                fontSize: 16.sp,
                color: AppColors.primaryColor
              
              ),)
            ],
          ),
        ),
         Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w , vertical: 10.h),

           child: Row(
            
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
         
            children: [
         
              Text('Time Difference' ,style: TextStyle(
                fontFamily: 'roboto_medium',
                fontSize: 16.sp,
                color: AppColors.primaryColor
              
              ),),
               Text('Time Difference' ,style: TextStyle(
                fontFamily: 'roboto_medium',
                fontSize: 16.sp,
                color: AppColors.primaryColor
              
              ),)
            ],
                 ),
         )


      ],
    ),
    
        ],
      ),



    );
  }
}
buildOpportunityList() {
  return  Expanded(
    child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      // padding: EdgeInsets.all(12.sp),
      itemCount:2,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Get.to( const OpportunitiesDetails());
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w  , vertical: 6.h),
            height: 120.h,
            width: 336.w,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.123),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
        
                      margin: EdgeInsets.only(left : 16.sp),
                      child:Text('Citrix Server',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
    
                      height: 22.h,
                      width: 99.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white
                      
                      ),
        
                      margin: EdgeInsets.only(left : 100.sp),
                      child:Center(
                        child: Text('Lead',
                            style: TextStyle(
                                color: Colors.pink,
                              fontSize: 14.sp,
                            )),
                      ),
                    ),
                      ],
                    ),
    
    
                    Container(
        
                      margin: EdgeInsets.only(left : 16.sp),
                      child:Text('19725',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          )),
                    ),
                    SizedBox(height: 3.h,),
        
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Value',
                                style: TextStyle(
                                  fontFamily: 'roboto_regular',
    
        
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.primaryColor,
        
        
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                '75000',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
    
    
                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 40.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Currency',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'roboto_regular',
                                  color: AppColors.primaryColor,
        
        
                                  fontSize: 14.sp,
                                ),
                              ),
    
                              SizedBox(
                                height: 5.h,
                              ),
    
                              Text(
                                'Indian Rupee',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
    
                          SizedBox(width: 20.w,),
    
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Closure Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'roboto_regular',
                                  color: AppColors.primaryColor,
        
        
                                  fontSize: 14.sp,
                                ),
                              ),
    
                              SizedBox(
                                height: 5.h,
                              ),
    
                              Text(
                                '25 Aug 2021',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
        
                        ],
                      ),
                    ),
        
        
                  ],
                ),
        
               
              ],
            ),
          ),
        );
      },
    ),
  );
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