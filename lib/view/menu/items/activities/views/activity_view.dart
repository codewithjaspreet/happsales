import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/activities/views/activity_view_controller.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';

import '../../../../../utils/color.dart';
import '../../contacts/widgets/SecondTypeDetailing.dart';
import '../../contacts/widgets/ThirdTypeDetailing.dart';
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
                            Get.to(ActivityEdit());
                          },
                          child:Container(
                            width: 22.w,
                            height: 22.h,
                            decoration: BoxDecoration(
      
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
                                              margin: EdgeInsets.only(left: 14.w,top: 10.h),
      
                                              width: 100.w,
                                              height: 100.h,
                                              decoration: BoxDecoration(
      
                                                color: Colors.grey.withOpacity(0.1),
      
      
      
                                              ),
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
                                              Text("ABC Limited",style: TextStyle(color: Color(0xff00A6D6),
      
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
                                color: Color(0xff00A6D6),
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
                        Text('Completed'),
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
                        Text('No'),
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
                  Text('Mr. Hughie campbell'),
                ],
              ),
            ) ),
       
      
      
          ],
        ),
          ),
      
          
      
                  OpportunityViewRow(subtite: '-', title: 'Opportunity Name',),
                  OpportunityViewRow(subtite: '-', title: 'Amount Collected',),
                  
                  OpportunityViewRow(subtite: '-', title: 'Collection Details',),
                  OpportunityViewRow(title: 'Travelled', subtite: '-'),
                  OpportunityViewRow(title: 'Travelled Purpose', subtite: '-'),
                  OpportunityViewRow(title: 'Currency', subtite: '-'),
                  OpportunityViewRow(title: 'InvoiceTitle', subtite: '-'),
                  OpportunityViewRow(title: 'User Name', subtite: '-'),
                  
                  
      
                                      
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
                                              child: Divider(
                                                color: Colors.grey,
                                              thickness: 0.8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),


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
                        ):SizedBox.shrink()),


                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
                    children: [

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
      
                        child: Text(
                          'Additional Details',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                            fontFamily: "roboto_bold"
                          ),
                        ),
                      ),
      
             
      
                      Obx(() => Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: GestureDetector(
                            onTap: (){
                            
                              activityViewController.isAdditional.value = !activityViewController.isAdditional.value;
                            },
                            child:Image.asset(
                                activityViewController.isAdditional.value ? "assets/contacts/up.png" : "assets/contacts/back.png")
                                
                                
                          ),
                      ),


                      


      
      
      
                        ),


      
                       
                    ],
                  ),

                      Obx(() =>  
                      activityViewController.isAdditional.value?
                      
                        DetailItems() : SizedBox.shrink(),
)

        ]),
      ),
    );
  }
}


class DetailItems extends StatelessWidget {
  const DetailItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              IndividualItem(imageUrl: 'assets/activities/forms.png', title: 'Forms',),
              IndividualItem(imageUrl: 'assets/activities/product.png', title: 'Products',),
              IndividualItem(imageUrl: 'assets/activities/photo.png', title: 'Photo',),
            ],
          ),
             Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              IndividualItem(imageUrl: 'assets/activities/teammember.png', title: 'Team Members',),
              IndividualItem(imageUrl: 'assets/activities/businessunit.png', title: 'Business Unit',),
              IndividualItem(imageUrl: 'assets/activities/document.png', title: 'Documents',),
            ],
          ),

          IndividualItem(imageUrl: 'assets/activities/chat.png', title: 'Chats',),
         SizedBox(height: 10.h,),
          Divider(
            color: Colors.grey,
            thickness: 0.8,
          ),

         Container(
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          child: OpportunityViewRow(title: 'Is Active', subtite: 'Yes')),



              ThirdTypeDetailing(title1: 'Created By', subTitle1: 'asd'.toString(), title2: 'Modified By', subTitle2: 'Suvarna Traders'),
              SizedBox(height: 12.h,),

              ThirdTypeDetailing(title1: 'Created On', subTitle1: 'asd'.toString(), title2: 'Modified On', subTitle2: '29 Dec 2021'),

        ],
      ),

    );

  }
}
class IndividualItem extends StatelessWidget {
  const IndividualItem({Key? key, required this.imageUrl, required this.title}) : super(key: key);

  final String imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: const Color(0xffF5F6F9),

            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(imageUrl),
                Text(

                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: "roboto_bold",
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),

              ],
            ),
          ),
        ),
       
      ],
    );
  }
}
