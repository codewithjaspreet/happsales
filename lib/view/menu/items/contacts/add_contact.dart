import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color.dart';
class AddContact extends StatelessWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        backgroundColor: Colors.transparent,



      ),


      body:  Column(
        children: [
          Container(
            margin:  EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

      Text("Add Contact",style: TextStyle(fontFamily: "roboto_bold" , color: AppColors.primaryColor ,fontSize: 20.sp ),),
               Row(
                 children: [
                   Container(
                     margin: EdgeInsets.only(right: 5.w,top: 8.w,),
                     child: Stack(
                       children: [
                         Positioned(

                             child: Image.asset("assets/contacts/chat.png")),
                         Positioned(
                           child: Container(
                             child: Padding(
                               padding: EdgeInsets.only(right: 15.w),
                               child: FittedBox(

                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("Long press Ami \nto fill the details",style: TextStyle(color: Colors.black,fontSize: 8.sp),),
                                   )),
                             ),
                           ),
                         ),

                       ],
                     ),
                   ),

                   Row(
                     children: [
                       Container(
                         margin: EdgeInsets.only(right: 40.w),

                         child: Image.asset("assets/contacts/ami.png"),
                       ),
                       Container(
                         margin: EdgeInsets.only(right: 12.w),
                         decoration: BoxDecoration(
                           color: Color(0xffB4C6D4),
                           shape: BoxShape.circle,
                         ),
                         width: 24.w,
                         height: 24.h,
                         child: Center(
                           child:Icon(
                             Icons.cancel_outlined,
                             color: Colors.white,
                           ),
                         ),
                       ),

                     ],
                   ),
                 ],
               )
              ],
            ),
          ),

          BusinessCard()

        ],
      )
    );
  }
}


class BusinessCard extends StatelessWidget {
  const BusinessCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      width: 336.w,
      height: 216.h,
      decoration: BoxDecoration(
        color: const Color(0xffF5F6F9),
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Container(
              child: Center(
                child : Icon(Icons.add,color: Colors.white,),
              ),
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(child: Image.asset("assets/contacts/add.png"),),
            Container(
              child: Text("add business card" , style: TextStyle(fontWeight: FontWeight.w500 , fontFamily: "roboto_medium" , fontSize: 18.sp),),)
          ],
        ),
      ),
    );
  }
}
