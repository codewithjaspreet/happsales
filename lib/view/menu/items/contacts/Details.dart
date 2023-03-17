import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          UserDetailCard(),
          Hdivider(),
          DetailRow(),



        ],
      ),
    );
  }

  Column UserDetailCard() {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.w,vertical: 15.h),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.h , left: 20.w),
                    child: Row(
                      children: [
                        Container(

                          width: 63.w,
                          height: 63.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.white,

                          ),

                          child: Container(
                            margin: EdgeInsets.only(left: 2.w),
                            child: Center(
                              child: Text("ST",style: TextStyle(color: AppColors.primaryColor,fontSize: 44.sp),),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.w),
                          child:  Text("Suvarna traders",style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                        ),

                      ],
                    ),

                  ),

                  Container(
                    margin: EdgeInsets.only(top: 15.h , left: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Radha Krishna",style: TextStyle(color: Colors.white,fontSize: 20.sp,fontFamily: "roboto_bold"),),
                        ),
                        Container(
                          child: Text("Maintenance Manager",style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                        ),
                      ]
                    ),
                  ),

                 Container(
                    margin: EdgeInsets.only(top: 15.h , left: 25.w),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         child: Text("99999 12345",style: TextStyle(color: Colors.white,fontSize: 14.sp ,fontFamily: "roboto_bold"),),
                       ),
                       Container(
                         child: Text("radha.krishna@SuvarnaTraders.com",style: TextStyle(color: Colors.white,fontSize: 14.sp ,fontFamily: "roboto_bold"),),
                       ),
                     ],
                   ),
                 )
                ],
              ),
              width: 337.w,
              height: 216.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffAA80F9),
                    Color(0xff6165D7),
                  ],
                )



              ),
            ),
          ],
        );
  }
}
