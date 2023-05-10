


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';
import '../../../../../utils/popups/date_picker.dart';
import '../../../../../utils/popups/search_filter.dart';
import 'InputOne.dart';
import 'ToggleButtonRow.dart';
import 'add_tag.dart';

class MoreAddDetails extends StatefulWidget {
  const MoreAddDetails({super.key});

  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<MoreAddDetails> {
  bool _isOpen = true;
  bool forAndroid = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          GestureDetector(
            onTap: (){
              _toggleDropdown();
            },
            child: Container(
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
          ),




          if(_isOpen)
            SingleChildScrollView(
              child: Column(
                children: [

                  const Input(title: 'Reporting To',),
                  const Input(title: 'LinkedIn link',),

                  // dob
                  // Input(title: 'last Name',),
                  const DatePickerFeild(labelText: 'Date of Birth',),



                  ToggleButtonRow(title : "BirthDay Reminder",isAlreadyActive: false,),


                  SearchAndFilter(),
                  // Input(title: 'Contact Alignment',),

                  const Input(title: 'Roles & Responsibilities',),
                  const Input(title: 'Past Accounts',),


                  const Input(title: 'Past designation',),
                  const Input(title: 'Reference History',),
                  const Input(title: 'Remarks',),

                  ToggleButtonRow(title : "Is Active" ,isAlreadyActive: true,),
                  ToggleButtonRow(title : "Is Primary Contact" ,isAlreadyActive: false,),


                  Container(

                    margin: EdgeInsets.only(right: 2.w),
                    height: 190.h,
                    width: 340.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      border: Border.all(color: Colors.blue.withOpacity(0.5),),
                    ),

                    child: const TagInputWidget(),
                  )








                ],
              ),
            ),


        ]
    );
  }

}


