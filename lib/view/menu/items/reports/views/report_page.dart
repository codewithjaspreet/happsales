import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';

import '../../opportunity/views/opportunity_listing.dart';
import '../../settings/views/items/calendersync/views/calender_sync.dart';
import '../../settings/views/items/importcontacts/views/import_contact.dart';
import '../../settings/views/items/myprofile/views/profile.dart';

import 'package:get/get.dart';

import '../../settings/views/items/syncstatus/views/sync_status.dart';
import 'mysalesperformance/my_sales_performance.dart';
class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(context),

      body: Stack(children: [



        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            Container(
              margin: EdgeInsets.only(top: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hi Deepak Check your Reports!' , style: TextStyle(fontSize: 20.sp,color: AppColors.primaryColor,fontFamily: 'roboto_bold'),),
                ],
              ),
            ),

            Container(
              child: Image.asset('assets/opportunity/banner.png'),
            ),
            Row(
            
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
      
              ],
            ),
        
        
          
          
        
          Container(
        margin: EdgeInsets.all(5.sp),
        child: 
        Column(
          children: [
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
        GestureDetector(
              onTap: () {
                
                Get.to(() => const MySalesPerformance());
              },
              child: const _buildGridItem(title : '   My Sales \nPerformance', image: 'assets/reports/sales.png' )),
            GestureDetector(
                onTap: () {
                  Get.to(() => const ImportContact());
                },
                child: const _buildGridItem(title : 'Pipeline', image: 'assets/reports/pipeline.png' )),
          
              ],
            ),
        
            Row(
              children: [
                       
        
        
            GestureDetector(
          
              child:             const _buildGridItem(title : 'Activity Trend', image: 'assets/reports/activity.png' ),
              onTap: () {
                Get.to(const CalenderSync());
              },
            ),
          
            GestureDetector(
              
              onTap: () {
                Get.to(() => const OpportunityListing());
              },
              child: const _buildGridItem(title : 'Expense', image: 'assets/reports/expense.png' )),
          
              ],
            ),
        
           
          ],
        ),
          ),
          ],
        ),
        



        bottomDetailsSheet()


      ]),
    );
  }
}


class _buildGridItem extends StatelessWidget {
  const _buildGridItem({Key? key, required this.title, required this.image}) : super(key: key);

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.w,right: 8.w , top: 12.h),
      width: 162.w,
      height: 120.h,
      decoration: BoxDecoration(
        color: const Color(0xffF0F2FE),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Column(
        
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                
                width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(image),
                    ),
                  ),
                  ),
              SizedBox(height: 13.h,),
              Expanded(
                child: Text(title, style: TextStyle(
                  color: const Color(0xff171A63),
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}

