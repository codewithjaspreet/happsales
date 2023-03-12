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
            margin:  EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

      Text("Add Contact",style: TextStyle(fontFamily: "roboto_bold" , color: AppColors.primaryColor ,fontSize: 20.sp ),),
               Row(
                 children: [
                   Container(
                     margin: EdgeInsets.only(right: 80.w,top: 8.w,),
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
                         )
                       ],
                     ),
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
               )
              ],
            ),
          ),

        ],
      )
    );
  }
}
