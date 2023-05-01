import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/ShareAccounts/widgets/share_alert.dart';
import '../../../../../../utils/color.dart';
import 'dart:math' as math;
import '../../../contacts/widgets/CustomAppBar.dart';
class ShareAccount extends StatelessWidget {
  const ShareAccount({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      appBar: CustomAppBar(context),

      body: SingleChildScrollView(

        child: Column(

          children: [

        Container(
        padding: EdgeInsets.all(12.sp),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Share Account' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    showShareDialogs(context);
                  },
                  child: Container(
                    margin:  EdgeInsets.only(right: 16.w),
                    width: 30.w,
                    height: 30.h,
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
            Container(
              padding: EdgeInsets.all(20.sp),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 35.r,
                    child: Center(
                        child:Text("a", style: TextStyle(
                            color: Colors.white , fontSize: 30.sp , fontWeight: FontWeight.w500
                        ),)
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("account owner to Deepak",style: TextStyle(color: AppColors.primaryColor,

                          fontSize: 20.sp , fontWeight: FontWeight.w500),),

                      SizedBox(height : 5.h),
                      Text("Aerospace".toUpperCase(),style: TextStyle(color: AppColors.primaryColor,

                          fontSize: 14.sp , fontWeight: FontWeight.w400),) ,

                      SizedBox(height: 5.h,),
                      Text("Bangalore",style: TextStyle(color: AppColors.primaryColor,

                          fontSize: 14.sp , fontWeight: FontWeight.w200),)
                    ],
                  )
                ],
              ),
            ),
            ShareRow(title: 'Administrator', subtitle: 'Sales Manager'),
            ShareRow(title: 'Fazil', subtitle: 'Developer'),
            ShareRow(title: 'Sunanda', subtitle: 'Sales Manager'),
          ],
        ),
      ),

    );
  }
}
class ShareRow extends StatelessWidget {
  const ShareRow({Key? key, required this.title, required this.subtitle}) : super(key: key);
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return           Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      width: 337.w,
      height: 90.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                          radius: 28.r,
                          child: Center(
                              child:Text(title[0].toUpperCase(), style: TextStyle(
                                  color: Colors.white , fontSize: 20.sp , fontWeight: FontWeight.w500
                              ),)
                          ),
                        ),
                        SizedBox(width: 12.w,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title ,style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,

                            ),),
                            SizedBox(height: 5.h,),
                            Text(subtitle,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16.sp,
                                fontFamily: "roboto_regular",

                              ),),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16.h ,left: 2.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.delete_outline,color: AppColors.primaryColor,)
                        ],
                      ),
                    )


                  ],
                ),
              ),


            ],
          )
      ),
    );

  }
}
