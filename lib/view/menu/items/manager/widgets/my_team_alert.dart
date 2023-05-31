
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/color.dart';

import '../../notes/views/view_notes.dart';
import 'dart:math' as math;

class MyTeamSearch extends StatelessWidget {
  const MyTeamSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w , vertical: 30.h),
      title: Row(
        children: [
          GestureDetector
          
          (
            onTap: (){
              Get.back();
            },
            child: Image.asset('assets/accounts/close.png',scale: 0.6,)),
          SizedBox(width: 70.w,),
          Text("Select Team ",style: TextStyle(color: AppColors.primaryColor , fontSize: 20.sp , fontWeight: FontWeight.bold),),
                    // SizedBox(width: 70.w,),

         
        
        ],
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      content: Container(
        width: 339.w,
        height: 604.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

             Container(
               width: 337.w,
                height: 35.h,
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                 color: const Color(0xffF5F6F9)
               ),
               child: TextField(
                 decoration: InputDecoration(
                     suffixIcon: const Icon(Icons.search , color: Colors.grey,),
                     border: OutlineInputBorder(
                       borderSide: BorderSide.none,
                       borderRadius: BorderRadius.circular(8.sp),
                     ),
                     filled: true,
                     contentPadding: EdgeInsets.symmetric(
                       horizontal: 10.w
                     ),
                     hintStyle: const TextStyle(color: Color(0xff707070)),
                     hintText: "Search",

                     fillColor: const Color(0xffF5F6F9)),
               ),
             ),

              SizedBox(height: 12.h,),
              teamList(),



            ],
          ),
        )
      ),

    );
  }
}
teamList() {

 
 
  return Container(
    // height: 1000.h,
    child: ListView.builder(
      shrinkWrap: true,
      // padding: EdgeInsets.all(12.sp),
      itemCount: 10,
      // itemCount: contactController.contacts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
  
            
           },
          child: Container(
            margin: EdgeInsets.only(top : 12.sp),
            height: 90.h,
              width: 337.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.4)),
  
              
              borderRadius: BorderRadius.circular(10.r),
  
            ),
  
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left : 12.sp),
                  width: 50.w,
                  height: 50.w,
                  decoration:  BoxDecoration(
                    color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
  ,
                    shape: BoxShape.circle
                  ),
                  child: GestureDetector(
                    onTap: (){
                      // Get.to(const AddContact());
                    },
                    child: Center(
                      child: Text('Deepak'.substring(0,1).toUpperCase() .toUpperCase(),style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'roboto_bold',
                        fontSize: 20.sp
                      ),),
                      
                      
                    ),
                  ),
                ),
  
                Container(
                  width: 150.w,
                  child: Column(
                  
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                  
                        margin: EdgeInsets.only(left : 16.sp),
                        child:Text('Deepak',style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: 'roboto_medium',
                          fontSize: 16.sp
                        ),),
                    
                      ),Container(
                        margin: EdgeInsets.only(left : 16.sp,top: 2.sp,),
                        child:Text('Tester',style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: 'roboto_regular',
                            fontSize: 14.sp
                        
                        ),),
                      ),
                    ],
                  ),
                ),
  
              ],
            ),
          ),
        );
      },
    ),
  );
}