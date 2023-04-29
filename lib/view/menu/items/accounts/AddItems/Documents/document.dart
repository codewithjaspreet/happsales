import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/color.dart';
import '../../../contacts/widgets/CustomAppBar.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Document',
                  style: TextStyle(
                      fontFamily: 'roboto_bold',
                      fontSize: 20.sp,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Container(
                  width: 126.w,
                  height: 126.h,
                  decoration: BoxDecoration(
                    color: Color(0xffF5F6F9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/accounts/media_add.png'),
                      Image.asset('assets/accounts/media_camera.png'),
                      Text(
                        'Document',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: "roboto_medium"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'HS_IG.docx',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.delete_outline,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),

                    Text('-')
                  ],
                )
            ),
            width: 337.w,
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: Colors.grey, width: 1),
            ),
          ),

          Expanded(
            child: Container(
              margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 45.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(child: Text(


                      "Cancel" , style:   TextStyle(color: Colors.white,fontSize: 18.sp),)),
                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),
                      color: Color(0xff8199AC),
                    ),
                  ),
                  Container(
                    child: Center(child: Text("Save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold",fontSize: 18.sp),)),
                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),

                      shape: BoxShape.rectangle,
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              ),
            ),
          )


        ],
      ),
    );
  }
}
