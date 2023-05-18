
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
            child: Image.asset('assets/opportunity/close.png')),
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
                  indicatorStyle: IndicatorStyle(color: Colors.blue),

                  endChild: Container(
                    margin: EdgeInsets.only(left: 30.w,top: 20.h),
                    child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                      Text('21 Dec 202101:09 PM'),
                      SizedBox(height: 10.h,),
                      Text('Recieve Order Completed',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                                            SizedBox(height: 10.h,),

                      Text('Recieve Order - Planned'),
                    ]),
                  ),
                
                isFirst: true,
                ),
              ),
               Container(

                child: TimelineTile(
                                    indicatorStyle: IndicatorStyle(color: Colors.blue),

                   endChild: Container(
                    margin: EdgeInsets.only(left: 30.w, top: 30.h),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                      Text('21 Dec 202101:09 PM'),
                      SizedBox(height: 10.h,),
                      Text('Recieve Order Completed',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                                            SizedBox(height: 10.h,),

                      Text('Recieve Order - Planned'),
                    ]),
                  ),
                  
                
                ),
              ),
               Container(
                child: TimelineTile(
                  indicatorStyle: IndicatorStyle(color: Colors.blue),

                   endChild: Container(
                    margin: EdgeInsets.only(left: 30.w,top: 30.h),

                    child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                      Text('21 Dec 202101:09 PM'),
                      SizedBox(height: 10.h,),
                      Text('Recieve Order Completed',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                                            SizedBox(height: 10.h,),

                      Text('Recieve Order - Planned'),
                    ]),
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


