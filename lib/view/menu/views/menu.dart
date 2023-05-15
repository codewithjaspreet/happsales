import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happsales_crm/view/menu/items/activities/views/activity_listing.dart';
import 'package:happsales_crm/view/menu/items/contacts/views/contact.dart';
import 'package:happsales_crm/view/menu/items/opportunity/views/opportunity_listing.dart';
import '../items/accounts/accounts.dart';
import '../items/notes/views/notes_listing.dart';
class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("HappSales" , style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin:  EdgeInsets.only(right: 10.w),
              child:  const Icon(Icons.close,color: Colors.black,),
            ),
          )
        ],

      ),
      body: Padding(
        padding:  EdgeInsets.all(12.sp),
        child: GridView(


          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 8,
          ),
          children:   <Widget>[
            const _buildGridItem(title : 'Home', image: 'assets/home.png' ),
            GestureDetector(
                onTap: () {
                  Get.to(() => const AccountPage());
                },
                child: const _buildGridItem(title : 'Accounts', image: 'assets/accounts.png' )),

            GestureDetector(

              child:             const _buildGridItem(title : 'Contacts', image: 'assets/contacts.png' ),
              onTap: () {
                Get.to(const ContactPage());
              },
            ),

            GestureDetector(
              
              onTap: () {
                Get.to(() => const OpportunityListing());
              },
              child: const _buildGridItem(title : 'Opportunities', image: 'assets/opportunities.png' )),
            GestureDetector(
              
               onTap: (){

                Get.to(const ActivityListing());
               },
              child: const _buildGridItem(title : 'Activities', image: 'assets/activities.png' )),
            const _buildGridItem(title : 'Resources', image: 'assets/resources.png' ),
            GestureDetector(
                onTap: () {
                  Get.to(() => const NotesListing());
                },
                child: const _buildGridItem(title : 'Notes', image: 'assets/notes.png' )),
            const _buildGridItem(title : 'Reports', image: 'assets/reports.png' ),
            const _buildGridItem(title : 'Attendance', image: 'assets/attendance.png' ),
            const _buildGridItem(title : 'Expense', image: 'assets/expense.png' ),
            const _buildGridItem(title : 'Settings', image: 'assets/settings.png' ),
            const _buildGridItem(title : 'Manager', image: 'assets/manager.png' ),
          ],
        ),
      ),
      );

  }

}/// /


class _buildGridItem extends StatelessWidget {
  const _buildGridItem({Key? key, required this.title, required this.image}) : super(key: key);

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.w,right: 8.w , top: 15.h),
      width: 162.w,
      height: 111.h,
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

