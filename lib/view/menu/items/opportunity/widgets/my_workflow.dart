
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../notes/views/view_notes.dart';


class WorkFlowStatus extends StatelessWidget {
  const WorkFlowStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w , vertical: 30.h),
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 25.w,
              height: 25.h,
              child: Image.asset('assets/opportunity/close.png'))),
          SizedBox(width: 40.w,),
          Text("Workflow Status",style: TextStyle(color: AppColors.primaryColor , fontSize: 20.sp , fontWeight: FontWeight.bold),),

        ],
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      content: Container(
        width: 339.w,
        height: 504.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                child: TimelineTile(

                  
                  beforeLineStyle: LineStyle(
                    
                    color: AppColors.themeColor,
                    thickness: 1.2,
                   
                  ),

                
                
                  indicatorStyle: IndicatorStyle(color: AppColors.themeColor),

                  endChild: Container(
                    margin: EdgeInsets.only(left: 30.w,top: 20.h),
                    child: Container(

                      margin: EdgeInsets.only(bottom: 20.h),
                      child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                    
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                    
                       Container(
                            margin: EdgeInsets.only(bottom: 5.h),
                            child: Text('21 Dec 202101:09 PM')),
                          Text('Recieve Order Completed',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                      
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            child: Text('Recieve Order - Planned',style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 12.sp,
                            ),)),
                      ]),
                    ),
                  ),
                
                isFirst: true,
                ),
              ),
               Container(

                child: TimelineTile(

                   beforeLineStyle: LineStyle(
                    color: AppColors.themeColor,
                    thickness: 1.2,
                   
                  
                  ),
                                    indicatorStyle: IndicatorStyle(color: AppColors.themeColor),

                   endChild: Container(
                    margin: EdgeInsets.only(left: 30.w, top: 30.h),

                    child: Container(
                      margin: EdgeInsets.only(bottom: 25.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                    
                        Container(
                          margin: EdgeInsets.only(bottom: 5.h),
                          child: Text('21 Dec 202101:09 PM')),
                        Text('Recieve Order Completed',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                    
                        Container(
                          margin: EdgeInsets.only(top: 5.h),
                          child: Text('Recieve Order Completed',style: TextStyle(
                              fontSize: 12.w,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.normal,
                            ))),
                      ]),
                    ),
                  ),
                  
                
                ),
              ),
               Container(
                child: TimelineTile(
                  indicatorStyle: IndicatorStyle(color: AppColors.themeColor),

                  beforeLineStyle: LineStyle(
                    color: AppColors.themeColor,
                    thickness: 1.2,
                   
                  
                  ),
                   endChild: Container(
                    margin: EdgeInsets.only(left: 30.w,top: 10.h),

                    child: Container(
                      child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                    
                        children: [
                    
                      Container(
                            margin: EdgeInsets.only(bottom: 5.h),
                            child: Text('21 Dec 202101:09 PM')),
                          Text('Recieve Order And Uploadto Tally Completed',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                      
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            child: Text('Review Order And Upload to Tally - Planned',style: TextStyle(
                              fontSize: 12.w,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.normal,
                            ),)),
                      ]),
                    ),
                  ),
                  
                isLast: true,
                ),
              ),
            ],
          ),
        )
      ),

    );
  }
}
_buildEmployeeListView() {

 

  return  SingleChildScrollView(
    child: SizedBox(
      height: 704.h,
      child: ListView.builder(

        itemCount: 3,
        itemBuilder: (context, index) {

          return Container(

            child: Row(children: [

              Column(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 50.h,
                    child: TimelineTile(
                      endChild: Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(50.sp),
                        ),
                      ),
                    ),
                  )
                  
                 


                ],
              ),
              
            ]),


          );
        
        },
      ),
    ),
  );
}


