import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';
import '../Details.dart';
import 'HDivider.dart';
import 'SecondTypeDetailing.dart';
import 'ThirdTypeDetailing.dart';

class MoreDetail extends StatefulWidget {
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<MoreDetail> {
  bool _isOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'More Details',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: "roboto_medium",
                        fontSize: 14.sp),
                  ),
                ],
              ),
              Row(

                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10.w),
                    child: GestureDetector(
                        onTap: (){},
                        child: Container(
                          child: Center(
                            child: Image.asset("assets/contacts/edit.png"),
                          ),
                          width: 24.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        )),
                  ),
                  GestureDetector(
                      onTap: _toggleDropdown,
                      child: Icon(
                          _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down)),

                ],
              )
            ],
          ),
        ),
        if (_isOpen)
          SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        SecondTypeDetailing(title: 'Reporting To', subTitle: 'Suresh Kumar'),
                        Detaling(title: 'LinkedIn', subTitle: 'https://www.linkedin.com/in/radha. krishna-4188a34/', imgUrl: 'assets/contacts/linkdeln.png',),
                        ThirdTypeDetailing(title1: 'DoB', subTitle1: '1st Dec 1987', title2: 'Reminder', subTitle2: 'no'),
                        SecondTypeDetailing(title: 'Contact Alignment', subTitle: 'Supporter'),
                        SecondTypeDetailing(title: 'Roles & Responsibilities', subTitle: 'Machine Maintenance'),
                        SecondTypeDetailing(title: 'Past Accounts', subTitle: 'Organic Trader'),
                        SecondTypeDetailing(title: 'Past Designations', subTitle: 'Maintenance Manager'),
                        SecondTypeDetailing(title: 'Reference History', subTitle: '-'),
                        SecondTypeDetailing(title: 'Tags', subTitle: 'Open'),
                        SecondTypeDetailing(title: 'Remarks', subTitle: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.'),
                        Hdivider(),
                        ThirdTypeDetailing(title1: 'is active', subTitle1: 'yes', title2: 'is primary contact', subTitle2: 'no'),
                        Hdivider(),
                        ThirdTypeDetailing(title1: 'created by', subTitle1: 'Mr. Radha R Krishna', title2: 'modified by', subTitle2: 'Suvarna Traders'),
                        ThirdTypeDetailing(title1: 'created on', subTitle1: '29 Dec 2021', title2: 'modified on', subTitle2: '29 Dec 2021'),



                      ]
                  ),
                ),
              ],
            ),
          )
      ]),
    );
  }
}