import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/activities/views/activity_view_controller.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';

import '../../../../../utils/color.dart';
import '../../opportunity/views/opportunity_view.dart';
import 'activity_edit.dart';

class ActivityDetails extends StatelessWidget {
  ActivityDetails({super.key});

  ActivityViewController activityViewController = ActivityViewController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
          
          Container(
              margin: EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Activity Details',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: "roboto_medium",
                            fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Row(
      
                    children: [
      
                      GestureDetector(
                          onTap: () {
                            Get.to(const ActivityEdit());
                          },
                          child:Container(
                            width: 22.w,
                            height: 22.h,
                            decoration: const BoxDecoration(
      
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                                ),
                            margin: EdgeInsets.only(right: 20.w),
                            child: Image.asset("assets/contacts/edit.png"),
                          )),
                          
      
                      Obx(() => GestureDetector(
                          onTap: (){
      
                            activityViewController.isOpen.value = !activityViewController.isOpen.value;
                          },
                          child:Image.asset(
                              activityViewController.isOpen.value ? "assets/contacts/up.png" : "assets/contacts/back.png")
                              
                              
                        ),
      
      
      
                        ),
      
                       
                    ],
                  )
                ],
              ),
            ),
      
             Obx(() => activityViewController.isOpen.value ?  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
      
                               // ThirdTypeDetailing(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: 10.h),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
      
                                            Container(
      
                                              margin: EdgeInsets.only(left: 14.w,top: 10.h),
      
                                              width: 100.w,
                                              height: 100.h,
                                              decoration: BoxDecoration(
      
                                                color: Colors.grey.withOpacity(0.1),
      
      
      
                                              ),
      
                                              child: Container(child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
      
                                                  Container(
      
                                                    width: 40.w,
                                                    height: 40.h,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: AppColors.primaryColor,width: 3.w)
                                                    ),
      
                                                    child: Icon(Icons.more_horiz,color: AppColors.primaryColor    ,size: 30.sp,),
                                            
                                                  ),
                                             
                                                Container(
                                                  margin: EdgeInsets.only(top: 10.h),
                                                  child: Text("Service",style: TextStyle(color:AppColors.primaryColor,
                                            
                                                
                                                      fontSize: 12.sp , fontWeight: FontWeight.normal),),
                                                ),
                                              
                                              ],)),
                                            )
      
                                        
                                          ],
                                        ),
      
                                        Container(
                                          margin: EdgeInsets.only(right: 100.sp,bottom: 28.h),
      
                                          child: Column(
      
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("HAPPSALES-ATVTY-000001484",style: TextStyle( color: AppColors.primaryColor,
      
                                              fontSize: 10.sp , fontWeight: FontWeight.normal),),
      
      
                                              SizedBox(height: 5.h,),
                                              Text("ABC Limited",style: TextStyle(color: const Color(0xff00A6D6),
      
                                              fontSize: 14.sp , fontWeight: FontWeight.bold),),
      
                                              SizedBox(height: 10.h,),
      
                                               Text("22 Sep 2002",style: TextStyle(color: AppColors.primaryColor,
      
                                              fontSize: 12.sp , fontWeight: FontWeight.bold),),
      
                                                
                                                
      
                                                
                                                
                                                
                                                ],
                                              ),
      
                                              
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
      
                                
                              ],
                            ),
      
      
      
      
                       Row(
                         children: [
                           Container(
                            margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 18.w),
                            width: 330.w,
                            
                             child: Text("Service [ABC Limited] On 22 Sep 2022 At 13:50",style: TextStyle(color: AppColors.primaryColor,
                             
                             fontSize: 16.sp , fontWeight: FontWeight.bold),),
                           ),
                         ],
                       ),
      
      
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            child: Text(
                              'Details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff00A6D6),
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.w),
      
                            child: Text(
                              '-',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                         
                          Container(
                           margin: EdgeInsets.only(top: 8.h,left: 5.w),
      
                            child: Text(
                              'Read More',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: const Color(0xff00A6D6),
                                fontSize: 12.sp,
                                fontFamily: 'roboto_regular'
                              ),
                            ),
                          ),

                          SizedBox(height :10.h),                  
      
      activityViewController.seeMore.value ? const SizedBox.shrink() :       GestureDetector(
                                onTap: (){
                                  activityViewController.toggleSeeMore();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.h, left: 16.w),
                                  width: 125.w,
                                  height:48.h,
                                  decoration: BoxDecoration(
                                    borderRadius:  BorderRadius.circular(26.sp),
      
                                    shape: BoxShape.rectangle,
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Center(child: Text("See More" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold",fontSize: 16.sp),)),
                                ),
                              ),
      
                                if(
                                  activityViewController.seeMore.value
                                )
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
      
      
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
              
                        Expanded(child:
                        Container(
                    margin: EdgeInsets.only(
                      left: 5.w,
                      top: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Activity Status',style: TextStyle(
                          fontSize: 13.sp ,
                          color: const Color(0xff00A6D6),
                          fontWeight: FontWeight.bold,
                          fontFamily: "roboto_bold",
                        ),),
                        SizedBox(height: 3.h,),
                        const Text('Completed'),
                      ],
                    ),
                        ) ),
                        Expanded(child:
                        Container(
                    margin: EdgeInsets.only(
                      left: 15.w,
                      top: 10.h
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Is Approved',style:  TextStyle(
                          fontSize: 13.sp ,
                          color: const Color(0xff00A6D6),
                          fontWeight: FontWeight.bold,
                          fontFamily: "roboto_bold",
                        ),),
                        SizedBox(height: 3.h,),
                        const Text('No'),
                      ],
                    ),
                        ) ),
              
              
                      ],
                    ),
                  ),
                  ],
                ),
              ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
      
            Expanded(child:
            Container(
              margin: EdgeInsets.only(
                left: 5.w,
                top: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Name',style: TextStyle(
                    fontSize: 13.sp ,
                    color: const Color(0xff00A6D6),
                    fontWeight: FontWeight.bold,
                    fontFamily: "roboto_bold",
                  ),),
                  SizedBox(height: 3.h,),
                  const Text('Mr. Hughie campbell'),
                ],
              ),
            ) ),
       
      
      
          ],
        ),
          ),
      
          
      
      const OpportunityViewRow(subtite: '-', title: 'Opportunity Name',),
      const OpportunityViewRow(subtite: '-', title: 'Amount Collected',),
      
      const OpportunityViewRow(subtite: '-', title: 'Collection Details',),
      const OpportunityViewRow(title: 'Travelled', subtite: '-'),
      const OpportunityViewRow(title: 'Travelled Purpose', subtite: '-'),
      const OpportunityViewRow(title: 'Currency', subtite: '-'),
      const OpportunityViewRow(title: 'InvoiceTitle', subtite: '-'),
      const OpportunityViewRow(title: 'User Name', subtite: '-'),
      
      
      
                                      
                                        !activityViewController.seeMore.value ? const SizedBox.shrink() :       GestureDetector(
                                        onTap: (){
                                          activityViewController.seeMore.value = !activityViewController.seeMore.value;
                                        },
                                        child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                                              width: 150.w,
                                              height:48.h,
                                              decoration: BoxDecoration(
                                                borderRadius:  BorderRadius.circular(26.sp),
                                  
                                                shape: BoxShape.rectangle,
                                                color: AppColors.primaryColor,
                                              ),
                                              child: Center(child: Text("See Less" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold",fontSize: 16.sp),)),
                                            ),

                                            Container(
                                              margin: EdgeInsets.only(top: 5.h)  ,
                                              child: const Divider(
                                                color: Colors.grey,
                                              thickness: 0.8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                        ],
                      ),
                    ),
                    // Image.asset(imgUrl),
      
                  ],
                ),
              ),
             
            ],
          )
        ],
          ),
      
                                    
      
      
                                                
                             
      
      
      
      
      
      
                          ],
                        ):const SizedBox.shrink())
        ]),
      ),
    );
  }
}