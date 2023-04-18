import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../models/contact.dart';
import '../../../../../utils/color.dart';
import '../views/Details.dart';
import 'HDivider.dart';
import 'SecondTypeDetailing.dart';
import 'ThirdTypeDetailing.dart';

class MoreDetail extends StatefulWidget {


  final Contact contact;
  const MoreDetail({ required this.contact});

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
      child: GestureDetector(
        onTap: _toggleDropdown,
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

                    GestureDetector(
                        onTap: _toggleDropdown,
                        child:Image.asset(
                            _isOpen ? "assets/contacts/up.png" : "assets/contacts/back.png")),

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


                          SecondTypeDetailing(title: 'Reporting To', subTitle: widget.contact.reportingManager!.toString(),),
                          Detaling(title: 'LinkedIn', subTitle: widget.contact.linkedIn.toString(), imgUrl: 'assets/contacts/linkdeln.png',),
                          ThirdTypeDetailing(title1: 'DoB', subTitle1: widget.contact.dateOfBirth!.toString(), title2: 'Reminder', subTitle2: 'no'),
                          SecondTypeDetailing(title: 'Contact Alignment', subTitle: widget.contact.contactAlignmentID!.toString(),),
                          SecondTypeDetailing(title: 'Roles & Responsibilities', subTitle: widget.contact.rolesAndResponsibilities!.toString(),),
                          SecondTypeDetailing(title: 'Past Accounts', subTitle: widget.contact.pastAccounts!.toString(),),
                          SecondTypeDetailing(title: 'Past Designations', subTitle: widget.contact.pastDesignations!.toString(),),
                          SecondTypeDetailing(title: 'Reference History', subTitle: '-'),
                          SecondTypeDetailing(title: 'Tags', subTitle: "Open",),
                          SecondTypeDetailing(title: 'Remarks', subTitle: widget.contact.remarks.toString(),),
                          Hdivider(),
                          ThirdTypeDetailing(title1: 'is active', subTitle1: widget.contact.isPrimaryContact.toString(), title2: 'is primary contact', subTitle2: 'no'),
                          Hdivider(),
                          ThirdTypeDetailing(title1: 'created by', subTitle1: widget.contact.createdBy!.toString(), title2: 'modified by', subTitle2: 'Suvarna Traders'),
                          ThirdTypeDetailing(title1: 'created on', subTitle1: widget.contact.createdOn!.toString(), title2: 'modified on', subTitle2: '29 Dec 2021'),



                        ]
                    ),
                  ),
                ],
              ),
            )
        ]),
      ),
    );
  }
}