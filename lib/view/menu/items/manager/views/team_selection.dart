import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';

import '../../opportunity/views/opportunity_listing.dart';
import '../../settings/views/items/calendersync/views/calender_sync.dart';
import '../../settings/views/items/importcontacts/views/import_contact.dart';
import '../../settings/views/items/myprofile/views/profile.dart';
import '../../settings/views/items/syncstatus/views/sync_status.dart';
import 'package:get/get.dart';
class TeamSelection extends StatelessWidget {
  const TeamSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Stack(
        children: [
          Column(
            children: [

              Container(
                margin: EdgeInsets.symmetric(vertical: 40.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                    children:[  Image.asset('assets/contacts.png'),
                    Container(
                      margin: EdgeInsets.only(top: 18.sp),
                      child: Text('Anish',style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'roboto_bold',
                        fontSize: 16.sp
                      ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.sp),
                      child: Text('Texter',style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                        fontFamily: 'roboto_medium'
                      ),),
                    )
                    ]
                    )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal : 5.sp,vertical: 10.h),
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
              


            ],
          ),
          bottomDetailsSheet(),
          
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
      margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
      width: 170.w,
      height: 125.h,
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