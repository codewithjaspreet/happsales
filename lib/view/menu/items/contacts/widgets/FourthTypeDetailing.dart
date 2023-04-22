import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/color.dart';

class FourthTypeDetailing extends StatelessWidget {

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }


  const FourthTypeDetailing(
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
      padding: EdgeInsets.only(top: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(child:
          Container(
            margin: EdgeInsets.only(
              left: 16.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title1,style: TextStyle(
                  fontSize: 13.sp ,
                  color: Color(0xff00A6D6),
                  fontWeight: FontWeight.bold,
                  fontFamily: "roboto_bold",
                ),),
                SizedBox(height: 3.h,),
                Row(
                  children: [
                    Text("8348234924"),
                    SizedBox(width: 10.w,),
                    Image.asset("assets/contacts/call.png",)
                  ],
                )
              ],
            ),
          ) ),
          Expanded(child:
          Container(
            margin: EdgeInsets.only(
              left: 32.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title2,style:  TextStyle(
                  fontSize: 13.sp ,
                  color: Color(0xff00A6D6),
                  fontWeight: FontWeight.bold,
                  fontFamily: "roboto_bold",
                ),),
                SizedBox(height: 3.h,),
                Row(
                  children: [
                    Text("8348234924"),
                    SizedBox(width: 10.w,),
                    Image.asset("assets/contacts/call.png",)
                  ],
                )
              ],
            ),
          ) ),

          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //             title1,
          //             style: TextStyle(
          //                 color: Color(0xff00A6D6),
          //                 fontFamily: "roboto_bold",
          //                 fontSize: 13.sp)),
          //
          //
          //
          //         AutoSizeText(
          //                     subTitle1,
          //
          //                     style: TextStyle(
          //                       fontSize: 16.sp,
          //
          //                       color: AppColors.primaryColor,
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                   ),
          //
          //       ],
          //     ),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(title2,
          //             style: TextStyle(
          //                 color: Color(0xff00A6D6),
          //                 fontFamily: "roboto_bold",
          //                 fontSize: 13.sp)),
          // AutoSizeText(
          //                     subTitle2,
          //
          //                     style: TextStyle(
          //                       fontSize: 16.sp,
          //
          //                       color: AppColors.primaryColor,
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                   ),
          //
          //       ],
          //     ),
        ],
      ),
    );
    // return Container(
    //   padding: EdgeInsets.only(left: 14.h, top: 20.h),
    //   child: Column(
    //     children: [
    //       Row(
    //         children: [
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Text(title1,
    //                       style: TextStyle(
    //                           color: Color(0xff00A6D6),
    //                           fontFamily: "roboto_bold",
    //                           fontSize: 13.sp)),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     subTitle1,
    //                     style: TextStyle(
    //                       fontSize: 16.sp,
    //                       fontFamily: "roboto_bold",
    //                       color: AppColors.primaryColor,
    //                       fontWeight: FontWeight.w400,
    //                     ),
    //                   ),
    //                   GestureDetector(
    //                     onTap: (){
    //                       _makePhoneCall(
    //                           "9336622215"
    //                       );
    //                     },
    //                     child: Container(
    //                       margin: EdgeInsets.only(left: 12.w),
    //                       child: Image.asset("assets/contacts/call.png"),
    //                     ),
    //                   )
    //                 ],
    //               )
    //             ],
    //           ),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Container(
    //                 margin: EdgeInsets.only(left: 55.w),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Text(title2,
    //                         style: TextStyle(
    //                             color: Color(0xff00A6D6),
    //                             fontFamily: "roboto_bold",
    //                             fontSize: 13.sp)),
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(left: 55.w),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Text(
    //                           subTitle2,
    //                           style: TextStyle(
    //                             fontSize: 16.sp,
    //                             fontFamily: "roboto_bold",
    //                             color: AppColors.primaryColor,
    //                             fontWeight: FontWeight.w400,
    //                           ),
    //                         ),
    //                         GestureDetector(
    //                           onTap: (){
    //                             _makePhoneCall(
    //                               "9336622215"
    //                             );
    //                           },
    //                           child: Container(
    //                             margin: EdgeInsets.only(left: 20.w),
    //                             child: Image.asset("assets/contacts/call.png"),
    //                           ),
    //                         )
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
