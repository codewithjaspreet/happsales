import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';

class AccountThirdTypeDetailing extends StatelessWidget {
  AccountThirdTypeDetailing(
      {Key? key,
        required this.title1,
        required this.subTitle1,
        required this.title2,
        required this.subTitle2})
      : super(key: key);

  final String title1;
  final String subTitle1;
  final String title2;
  final String subTitle2;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.h,

        top: 20.h,
        right: 20.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title1,
                  style: TextStyle(
                      color: Color(0xff00A6D6),
                      fontFamily: "roboto_bold",
                      fontSize: 13.sp)),
      AutoSizeText(
                          subTitle1,

                          style: TextStyle(
                            fontSize: 16.sp,

                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

            ],
          ),Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title2,
                    style: TextStyle(
                        color: Color(0xff00A6D6),
                        fontFamily: "roboto_bold",
                        fontSize: 13.sp)),
      AutoSizeText(
                            subTitle2,

                            style: TextStyle(
                              fontSize: 16.sp,

                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

              ],
            ),
          ),
        ],
      ),
      // child: Column(
      //   children: [
      //     Row(
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Text(title1,
      //                     style: TextStyle(
      //                         color: Color(0xff00A6D6),
      //                         fontFamily: "roboto_bold",
      //                         fontSize: 13.sp)),
      //               ],
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 AutoSizeText(
      //                   subTitle1,
      //
      //                   style: TextStyle(
      //                     fontSize: 16.sp,
      //
      //                     color: AppColors.primaryColor,
      //                     fontWeight: FontWeight.w400,
      //                   ),
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Container(
      //               margin: EdgeInsets.only(left: 80.w),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: [
      //                   Text(title2,
      //                       style: TextStyle(
      //                           color: Color(0xff00A6D6),
      //                           fontFamily: "roboto_bold",
      //                           fontSize: 13.sp)),
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               margin: EdgeInsets.only(left: 100.w),
      //               child: Row(
      //                 children: [
      //                   AutoSizeText(
      //                     subTitle2,
      //                     style: TextStyle(
      //                       fontSize: 16.sp,
      //                       color: AppColors.primaryColor,
      //                       fontWeight: FontWeight.w400,
      //                     ),
      //                   ),
      //
      //
      //
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}
