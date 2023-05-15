import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/contacts/add_contact.dart';

import '../../../../../../../../utils/color.dart';
import '../../../../../notes/views/view_notes.dart';
import '../widgets/popup.dart';

class Closed extends StatelessWidget {
  const Closed({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(children: [
       Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Opportunities' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
          Row(
            children: [
              const ClosedPopUp(),
              GestureDetector(
                onTap: (){
                  Get.to(const AddContact());
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


      Image.asset('assets/opportunity/banner.png'),
      buildOpportunityList(),

       

      

      ]),
    );
  }
}

buildOpportunityList() {
  return  Expanded(
      child: ListView.builder(
        // padding: EdgeInsets.all(12.sp),
        itemCount:6,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Get.to(const ViewnNotes());
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w  , vertical: 6.h),
              height: 130.h,
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

                        height: 18.h,
                        width: 105.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white
                        
                        ),
          
                        margin: EdgeInsets.only(left : 100.sp),
                        child:Center(
                          child: FittedBox(
                            child: Text('S5-Won,Delivered',
                                style: TextStyle(
                                    color: Colors.pink,
                                  fontSize: 14.sp,
                                )),
                          ),
                        ),
                      ),
                        ],
                      ),
                      SizedBox(height: 2.h,),


                      Container(
          
                        margin: EdgeInsets.only(left : 16.sp),
                        child:Text('Kumar Agency',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                              fontSize: 14.sp,
                            )),
                      ),
                      SizedBox(height: 5.h,),
          
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

                      SizedBox(height: 12.h,),

                      Container(
                        margin: EdgeInsets.only(left: 140.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                      
                            Text('Incoming',style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold

                            ),)
                          ],
                        ),
                      )
          
          
                    ],
                  ),
          
                 
                ],
              ),
            ),
          );
        },
      ));
}