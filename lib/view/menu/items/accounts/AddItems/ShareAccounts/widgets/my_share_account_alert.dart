import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:happsales_crm/utils/color.dart';
import 'dart:math' as math;

class MyShareAccountAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15.w , vertical: 30.h),
      title: Row(
        children: [
          Image.asset('assets/accounts/close.png'),
          SizedBox(width: 70.w,),
          Text("Select User",style: TextStyle(color: AppColors.primaryColor , fontSize: 20.sp , fontWeight: FontWeight.bold),),
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
               child: TextField(
                 decoration: InputDecoration(
                     suffixIcon: Icon(Icons.search , color: Colors.grey,),
                     border: OutlineInputBorder(
                       borderSide: BorderSide.none,
                       borderRadius: BorderRadius.circular(8.sp),
                     ),
                     filled: true,
                     contentPadding: EdgeInsets.symmetric(
                       horizontal: 10.w
                     ),
                     hintStyle: TextStyle(color: Color(0xff707070)),
                     hintText: "Search",

                     fillColor: Color(0xffF5F6F9)),
               ),

               width: 337.w,
                height: 35.h,
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                 color: Color(0xffF5F6F9)
               ),
             ),

              SizedBox(height: 12.h,),
              _buildEmployeeListView(),



            ],
          ),
        )
      ),

    );
  }
}
_buildEmployeeListView() {

  int generateRandomColorInt() {
    Random random =  Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    int color = (r << 16) + (g << 8) + b;
    return color;
  }

  return  SingleChildScrollView(
    child: Container(
      height: 704.h,
      child: ListView.builder(

        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){

              //print("THE ID IS${contactController.contacts[index].contactID}");
              //Get.to(() => ContactDetails(Id : contactController.contacts[index].contactID,));
            },
            child: Container(
              margin: EdgeInsets.only(top : 12.sp),
              height: 80.h,
              width: 337.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),

                color: Colors.white ,
                borderRadius: BorderRadius.circular(10.r),

              ),

              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left : 12.sp),
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
                        ,
                        shape: BoxShape.circle
                    ),
                    child: GestureDetector(
                      onTap: (){
                        //Get.to(AddContact());
                      },
                      child: Center(
                        child: Text('S'.toUpperCase(),style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp
                        ),),
                      ),
                    ),
                  ),

                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        margin: EdgeInsets.only(left : 16.sp),
                        child: Text('Jaspreet',style: TextStyle(
                            color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp
                        ),),
                      ),Container(
                        margin: EdgeInsets.only(left : 16.sp,top: 2.sp,),
                        child: Text('Tester',
                            style: TextStyle(
                              fontSize: 14.sp,
                                color: AppColors.primaryColor
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}