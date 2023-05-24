import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/notes/widgets/notes_popup.dart';
import 'package:happsales_crm/view/menu/items/opportunity/widgets/menu_popup.dart';

import '../../../../../utils/color.dart';
import '../../notes/views/view_notes.dart';
import '../widgets/resource_popup.dart';

class ResourceListing extends StatelessWidget {
  const ResourceListing({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(context),

      body: Column(children: [

       
       Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(
            margin: EdgeInsets.only(left: 5.w),
            child: Text('Resources',style: TextStyle(
              fontFamily: 'roboto_bold',
              fontSize: 20.sp,
              color: AppColors.primaryColor
            
            ),),
          ),
          
          ResourcePopup()
        ],
      ),
    ),

    Container(
      child: Image.asset('assets/resources/resourceheader.png'),
    ),
    buildNotesList(),
      ]),
    );
  }
}
buildNotesList() {
  return  Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(12.sp),
        itemCount:1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Get.to(const ViewnNotes());
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 13.w  , vertical: 6.h),
              height: 99.h,
              width: 336.w,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffB4C6D4).withOpacity(0.8)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left : 12.sp,bottom: 4.h),
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                        color: const Color(0xff00A6D6).withOpacity(0.1),
                    ),
                    child: Image.asset('assets/resources/pdf.png',scale: 0.7,),
                  ),

                  SizedBox(height: 10.h,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Row(
                      children: [
                         Container(
          
                        margin: EdgeInsets.only(left : 16.sp),
                        child:Text('Testing Resource 2',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        margin:   EdgeInsets.only(left: 68.w),
                        child: Icon(Icons.upload_file_outlined , color: AppColors.primaryColor,size: 20.sp,),
                      )
                      ],
                     ),
                      Container(
                        width: 230.w,
                        margin: EdgeInsets.only(left : 16.sp,top: 4.h),
                        child:Text('dfsdfjdfsdfdhfdhjsfsdfdfhfhdsffhdjsf',overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal
                            )),
                      
                      ),
                      SizedBox(height: 5.h,),

                      Container(
                        margin: EdgeInsets.only(left : 16.sp),
                        child: Row(
                          children: [
                      
                             Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Category',
                                    style: TextStyle(
                                      fontFamily: 'roboto_regular',
                                
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff00A6D6),
                                
                                
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'feyihu',
                                    style: TextStyle(
                                
                                      color: AppColors.primaryColor,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 70.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Valid Upto',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'roboto_regular',
                                      color: const Color(0xff00A6D6),
                                
                                
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    '31 Mar 2023',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
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