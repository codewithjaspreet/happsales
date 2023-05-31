import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/manager/views/my_team.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';
import 'package:get/get.dart';
class Managerpage extends StatelessWidget {
  const Managerpage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Stack(
        children: [



          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: 
            Text('Manager',style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold
            ),),
          ),

          Column(children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 28.sp),
                  
                  child: Image.asset('assets/opportunity/banner.png')),
              ],
            ),

            Row(
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(MyTeam());
                },
                child: _buildGridItem(title: 'My Team', image: 'assets/contacts.png')),
            
          _buildGridItem(title: 'Reports', image: 'assets/reports.png'),
            
            ],
            ),
            
          ],),





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
      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
      width: 165.w,
      height: 120.h,
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