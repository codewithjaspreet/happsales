import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';

class TagInputWidget extends StatefulWidget {
  const TagInputWidget({super.key});

  @override
  _TagInputWidgetState createState() => _TagInputWidgetState();
}

class _TagInputWidgetState extends State<TagInputWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp , vertical: 50.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

       Row(

            children: const [

            ],

          ) ,
          const Divider(
            color: Colors.grey,
            thickness: 1.2,

          )

          ,const Text('contact'),
          SizedBox(height: 10.h,),


         Row(
           children: [
             GestureDetector(
               onTap: (){

               },
               child: Container(

                 width: 88.w,
                 height: 44.h,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12.r),
                   border: Border.all(color: AppColors.primaryColor),
                   color: const Color(0xffE5F6FF),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('contact2' , style: TextStyle(
                       color: AppColors.primaryColor,
                       fontSize: 12.sp,
                       fontWeight: FontWeight.bold,
                     ),),
                     SizedBox(width: 5.w,),
                     Image.asset('assets/accounts/close2.png')
                   ],
                 ),
               ),
             ),
             SizedBox(width: 10.w,),
             GestureDetector(
               onTap: (){

               },
               child: Container(

                 width: 88.w,
                 height: 44.h,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12.r),
                   border: Border.all(color: AppColors.primaryColor),
                   color: const Color(0xffE5F6FF),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('contact2' , style: TextStyle(
                       color: AppColors.primaryColor,
                       fontSize: 12.sp,
                       fontWeight: FontWeight.bold,
                     ),),
                     SizedBox(width: 5.w,),
                     Image.asset('assets/accounts/close2.png')
                   ],
                 ),
               ),
             ),
           ],
         )





        ],
      ),
    );
  }


}
