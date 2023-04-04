import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/models/accounts.dart';
import 'package:happsales_crm/view/menu/items/accounts/AccountDetails.dart';

import '../../../../../models/contact.dart';
import '../../../../../utils/color.dart';


class AccountMoreDetail extends StatefulWidget {


  final Account account;
  const AccountMoreDetail({  required this.account});

  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<AccountMoreDetail> {
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

                        AccountDetailItems()

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