import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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

      ),
      body: GridView(


        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14.0,
          crossAxisSpacing: 14,
        ),
        children:  const <Widget>[
          _buildGridItem(title : 'home', image: 'assets/home.png' ),
          _buildGridItem(title : 'Accounts', image: 'assets/accounts.png' ),
          _buildGridItem(title : 'Contacts', image: 'assets/contacts.png' ),
          _buildGridItem(title : 'Opportunities', image: 'assets/opportunities.png' ),
          _buildGridItem(title : 'Activities', image: 'assets/activities.png' ),
          _buildGridItem(title : 'Resources', image: 'assets/resources.png' ),
          _buildGridItem(title : 'Notes', image: 'assets/notes.png' ),
          _buildGridItem(title : 'Reports', image: 'assets/reports.png' ),
          _buildGridItem(title : 'Attendance', image: 'assets/attendance.png' ),
          _buildGridItem(title : 'expense', image: 'assets/expense.png' ),
          _buildGridItem(title : 'Settings', image: 'assets/settings.png' ),
          _buildGridItem(title : 'manager', image: 'assets/manager.png' ),
        ],
      ),
      );

  }

}/**/


class _buildGridItem extends StatelessWidget {
  const _buildGridItem({Key? key, required this.title, required this.image}) : super(key: key);

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.sp),
      width: 162.w,
      height: 111.h,
      decoration: BoxDecoration(
        color: Color(0xffF0F2FE),
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
            SizedBox(height: 3.h,),
            Text(title, style: TextStyle(
              color: Color(0xff171A63),
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

