


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';
import '../../../../../utils/popups/date_picker.dart';
import '../../../../../utils/popups/search_filter.dart';
import 'DropDownInput.dart';
import 'InputOne.dart';
import 'ToggleButtonRow.dart';
import 'add_tag.dart';

class MoreAddDetails extends StatefulWidget {
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<MoreAddDetails> {
  bool _isOpen = false;
  bool forAndroid = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _toggleDropdown();
      },
      child: Column(
          children:[
            Container(
              margin: EdgeInsets.only(top: 15.h  , left: 16.w , right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Additional Section' ,style: TextStyle(color: AppColors.primaryColor,fontFamily: "roboto_bold" ,
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

                    Input(title: 'Reporting To',),
                    Input(title: 'LinkedIn link',),

                    // dob
                    // Input(title: 'last Name',),
                    DatePickerFeild(labelText: 'Date of Birth',),


                    ToggleButtonRow(title : "BirthDay Reminder"),
                    SearchAndFilter(),
                    // Input(title: 'Contact Alignment',),

                    Input(title: 'Roles & Responsibilities',),
                    Input(title: 'Past Accounts',),


                    Input(title: 'Past designation',),
                    Input(title: 'Reference History',),
                    Input(title: 'Remarks',),

                    ToggleButtonRow(title : "Is active"),
                    ToggleButtonRow(title : "Is Primary Contact"),


                    Container(

                      child: Column(

                        children: [

                          TagInputWidget()
                        ],
                      ),

                      margin: EdgeInsets.only(right: 2.w),
                      height: 190.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        border: Border.all(color: Colors.blue.withOpacity(0.5),),
                      ),
                    )








                  ],
                ),
              ),


          ]
      ),
    );
  }

}


