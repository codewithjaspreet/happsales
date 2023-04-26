import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/color.dart';

class FifthTypeDetailing extends StatelessWidget {
  const FifthTypeDetailing(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 14.w,
            top: 20.h,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: "roboto_bold",
             color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(subTitle,style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "roboto_bold",
                    color: Colors.blue,
                    fontWeight: FontWeight.w400),),

              ),
              GestureDetector(
                  onTap: (){
                    launchUrl(Uri.parse('mailto:rajatrrpalankar@gmail.com'));
                  },
                  child: Image.asset("assets/contacts/mail.png"))
            ],
          ),
        )
      ],
    );
  }
}
