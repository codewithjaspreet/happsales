import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class Recommendations extends StatelessWidget {
  const Recommendations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Hi Robin, these Activities needs your immediate attention!", textAlign: TextAlign.center, style: TextStyle(

                  color: const Color(0xff171A63),fontWeight: FontWeight.bold,fontFamily: GoogleFonts.roboto().fontFamily,fontSize: 22.sp,
                ),),
                SizedBox(height: 10.h,),

                Container(
                    padding: EdgeInsets.all(12.sp),
                    child: Image.asset("assets/Icons/Android/7_DashBoard/Activity/drawable-hdpi/img_dashboard_activity.png")),
                Container(

                  child: Column(
                    children: [
                      rowItem(title: 'Overdue', subtitle: 'Activities Overdue', avatarTitle: 5.toString()),
                      rowItem(title: 'Today', subtitle: 'Activities scheduled \nfor today', avatarTitle: 4.toString(),),
                      rowItem(title: 'week', subtitle: 'Activities scheduled for \nthe week', avatarTitle: 20.toString()),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}

class rowItem extends StatelessWidget {
  const rowItem({
    Key? key, required this.title, required this.subtitle, required this.avatarTitle,
  }) : super(key: key);

  final String title;
  final String avatarTitle;
  final String subtitle ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      width: 336.w,
      height: 160.h,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
        color: const Color(0xffFFFFFF),

      ),

      child: Column(
        children: [
          Container(

            child: Row(
              children: [
                Container(
                  width: 250.w,
                  child: Text("New Activity Assigned - \nMeeting - 03 -Feb-2023-\n HAPPSALES-ATVTY-0000002123-\n \"Meeting with Arnav [Paramount pictures] on 03 Feb 2023 At 19:42\")", textAlign: TextAlign.left, style: TextStyle(

                    color: const Color(0xff171A63),fontWeight: FontWeight.bold,fontFamily: GoogleFonts.roboto().fontFamily,fontSize: 16.sp,
                  ),),
                ),
                
              ],
            ),
          )
        ],
      ),

      // child: Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Container(
      //       margin: EdgeInsets.only(left: 20.w),
      //       child: CircleAvatar(
      //         backgroundColor: const Color(0xffE5F6FF),
      //         radius: 30.sp,
      //         child: Center(child: Text(avatarTitle,style: TextStyle(color: const Color(0xff171A63),fontWeight: FontWeight.bold,fontSize: 37.sp),)),
      //         // backgroundImage: AssetImage("assets/logo.png"),
      //       ),
      //     ),
      //     Container(
      //       margin: EdgeInsets.only(left: 20.w),
      //       child: Column(
      //
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //
      //         children: [
      //           Text(title, style: TextStyle(
      //
      //             color: const Color(0xff171A63),fontWeight: FontWeight.bold,fontFamily: GoogleFonts.roboto().fontFamily,fontSize: 28.sp,
      //           ),),
      //
      //           SizedBox(height: 5.h,),
      //           Text(subtitle, style: TextStyle(
      //
      //             color: const Color(0xff171A63),fontWeight: FontWeight.w400,fontFamily: GoogleFonts.roboto().fontFamily,fontSize: 16.sp,
      //           ),),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
