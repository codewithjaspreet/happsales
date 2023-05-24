import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/settings/views/items/calendersync/views/calender_sync.dart';
import 'package:happsales_crm/view/menu/items/settings/views/items/importcontacts/views/import_contact.dart';
import 'package:happsales_crm/view/menu/items/settings/views/items/myprofile/views/profile.dart';
import 'package:happsales_crm/view/menu/items/settings/views/items/syncstatus/views/sync_status.dart';

import '../../../../../utils/color.dart';
import '../../accounts/accounts.dart';
import '../../activities/views/activity_listing.dart';
import '../../attendance/views/attendance_listing.dart';
import '../../contacts/contact.dart';
import '../../notes/views/notes_listing.dart';
import '../../opportunity/views/opportunity_listing.dart';
import '../../resources/views/resource_listing.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
          padding: EdgeInsets.all(12.sp),
          child: Row(
        
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text('Settings' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),)),
             
            ],
          ),
          
        
            ),
        
        
            Container(
          margin: EdgeInsets.only(top: 14.h,right: 12.w),
          child: Image.asset('assets/settings/header.png'))
            
            ,
        
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
                      
                      Get.to(() => const MyProfile());
                    },
                    child: const _buildGridItem(title : 'My Profile', image: 'assets/settings/profile.png' )),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => const ImportContact());
                      },
                      child: const _buildGridItem(title : 'Import Contacts', image: 'assets/settings/important.png' )),
            
                    ],
                  ),
        
                  Row(
                    children: [
                             
        
        
                  GestureDetector(
            
                    child:             const _buildGridItem(title : 'Calender Sync', image: 'assets/settings/calender_sync.png' ),
                    onTap: () {
                      Get.to(const CalenderSync());
                    },
                  ),
            
                  GestureDetector(
                    
                    onTap: () {
                      Get.to(() => const OpportunityListing());
                    },
                    child: const _buildGridItem(title : 'Backup Data', image: 'assets/settings/back.png' )),
            
                    ],
                  ),
        
                  Row(
                    children: [
        
                                 GestureDetector(
                    
                     onTap: (){
            
                      Get.to(const SyncStatus());
                     },
                    child: const _buildGridItem(title : 'Sync Status', image: 'assets/settings/sync.png' )),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SyncStatus());
                    },
                    child: const _buildGridItem(title : 'logout', image: 'assets/settings/logout.png' )),
            
            
                    ],
                  )
                ],
              ),
            ),
            // Container(
            //   height: 400.h,
            //   child: GridView(
            
            
            //     gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
            //        crossAxisCount: 2,
            //     mainAxisSpacing: 4.0,
            //     crossAxisSpacing: 8,
            //     ),
            //     children:   <Widget>[
          
            
           
            //         
            //
            //   ],
            //   ),
            // ),
            ],
          ),
        ),
      ),

      
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
      margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
      width: 170.w,
      height: 150.h,
      decoration: BoxDecoration(
        color: const Color(0xffF0F2FE),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
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
            SizedBox(height: 12.h,),
            Text(title, style: TextStyle(
              color: const Color(0xff171A63),
              fontSize: 16.sp,
              fontFamily: "roboto_medium"
            ),)
          ],
        ),
      ),
    );
  }
}