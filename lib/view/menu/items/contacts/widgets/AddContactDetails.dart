


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';
import 'DropDownInput.dart';
import 'InputOne.dart';

class AddContactDetails extends StatefulWidget {
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<AddContactDetails> {
  bool _isOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          Container(
            margin: EdgeInsets.only(top: 15.h  , left: 16.w , right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Contact Details' ,style: TextStyle(color: AppColors.primaryColor,fontFamily: "roboto_medium" ,
                        fontSize: 14.sp),),


                  ],
                ),
                GestureDetector(
                    onTap: _toggleDropdown,
                    child: Image.asset(_isOpen ? "assets/contacts/back.png" : "assets/contacts/up.png")),

              ],
            ),

          ),




          if(_isOpen)
            SingleChildScrollView(
              child: Column(
                children: [
                  DropDownInput(hint : 'Title *'),
                  Input(title: 'First Name*',),
                  Input(title: 'last Name',),
                  Input(title: 'account name',),
                  DropDownInput(hint : 'designation'),
                  DropDownInput(hint : 'Mobile Number'),
                  Input(title: 'Mobile Number',),
                  Input(title: 'alternate Mobile Number',),
                  Input(title: 'Work Phone',),
                  Input(title: 'residence phone',),
                  Input(title: 'email address',),
                  Input(title: 'alternate email address',),
                  Input(title: 'Address Line',),
                  Input(title: 'Address Line 2',),
                  Input(title: 'Address Line 3',),
                  DropDownInput(hint: 'city',),
                  DropDownInput(hint:  'state',),
                  DropDownInput(hint: 'country',),
                  Input(title: 'pincode',),
                  Input(title: 'GPS Coordinate',),







                ],
              ),
            ),


        ]
    );
  }

}



