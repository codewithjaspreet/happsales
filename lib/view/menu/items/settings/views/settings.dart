import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';

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
      body: Column(
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
          height: 400.h,
          child: GridView(
        
        
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 8,
            ),
            children:   <Widget>[
              const _buildGridItem(title : 'My Profile', image: 'assets/settings/profile.png' ),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const AccountPage());
                  },
                  child: const _buildGridItem(title : 'Import Contacts', image: 'assets/settings/important.png' )),
        
              GestureDetector(
        
                child:             const _buildGridItem(title : 'Calender Sync', image: 'assets/settings/calender_sync.png' ),
                onTap: () {
                  Get.to(const ContactPage());
                },
              ),
        
              GestureDetector(
                
                onTap: () {
                  Get.to(() => const OpportunityListing());
                },
                child: const _buildGridItem(title : 'Backup Data', image: 'assets/settings/back.png' )),
              GestureDetector(
                
                 onTap: (){
        
                  Get.to(const ActivityListing());
                 },
                child: const _buildGridItem(title : 'Sync Status', image: 'assets/settings/sync.png' )),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ResourceListing());
                },
                child: const _buildGridItem(title : 'logout', image: 'assets/settings/logout.png' )),
                   ],
          ),
        ),
        ],
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
      margin: EdgeInsets.only(left: 10.w,right: 10.w , top: 15.h),
      width: 100.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: const Color(0xffF0F2FE),
        borderRadius: BorderRadius.circular(18.r),
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
            SizedBox(height: 3.h,),
            Text(title, style: TextStyle(
              color: const Color(0xff171A63),
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),)
          ],
        ),
      ),
    );
  }
}