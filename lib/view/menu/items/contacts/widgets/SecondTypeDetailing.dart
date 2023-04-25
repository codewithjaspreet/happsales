import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';

class SecondTypeDetailing extends StatelessWidget {
  const SecondTypeDetailing(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: EdgeInsets.only(
    //     top: 4.h,
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           // Container(
    //           //   padding: EdgeInsets.only(left: 16.h, top: 10.h, right: 16.w),
    //           //   child: Column(
    //           //     children: [
    //           //       Row(
    //           //         mainAxisAlignment: MainAxisAlignment.start,
    //           //         children: [
    //           //           Text(title,
    //           //               style: TextStyle(
    //           //                   color: Color(0xff00A6D6),
    //           //                   fontFamily: "roboto_bold",
    //           //                   fontSize: 13.sp)),
    //           //         ],
    //           //       ),
    //           //       Row(
    //           //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           //         children: [
    //           //           Flexible(child: Text(
    //           //             subTitle,
    //           //             style: TextStyle(
    //           //               fontSize: 16.sp,
    //           //               color: AppColors.primaryColor,
    //           //               fontWeight: FontWeight.w400,
    //           //             ),
    //           //           ),)
    //           //         ],
    //           //       )
    //           //     ],
    //           //   ),
    //           // ),
    //           Container(
    //             padding: EdgeInsets.all(20.sp),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         title,
    //                         style: TextStyle(
    //                           // fontWeight: FontWeight.bold,
    //
    //
    //                           fontSize: 12.sp,
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 3.h,
    //                       ),
    //                       Text(
    //                         subTitle,
    //                         style: TextStyle(
    //                           color: AppColors.primaryColor,
    //                           fontSize: 14.sp,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 // Image.asset(imgUrl),
    //
    //               ],
    //             ),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20.sp),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Image.asset(imgUrl),

                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(left: 16.h, top: 10.h, right: 16.w),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Text(title,
            //               style: TextStyle(
            //                   color: Color(0xff00A6D6),
            //                   fontFamily: "roboto_bold",
            //                   fontSize: 13.sp)),
            //         ],
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Flexible(
            //             child: Text(
            //               subTitle,
            //               style: TextStyle(
            //                 fontSize: 16.sp,
            //                 color: AppColors.primaryColor,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //             ),
            //           ),
            //           Image.asset(imgUrl)
            //         ],
            //       )
            //     ],
            //   ),
            // )
          ],
        )
      ],
    );
  }
}