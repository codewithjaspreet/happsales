


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/popups/custom_dropdown.dart';

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
                children: const  [
                   CustomDropDown(labelText: 'Title *',items: [ DropdownMenuItem(
                     value: 'Item 1',
                     child: Text('Mr.'),
                   ),
                     DropdownMenuItem(
                       value: 'Item 2',
                       child: Text('Mrs.'),
                     ),
                     DropdownMenuItem(
                       value: 'Item 3',
                       child: Text('Miss.'),
                     ),DropdownMenuItem(
                       value: 'Item 3',
                       child: Text('Mx.'),
                     ),DropdownMenuItem(
                       value: 'Item 3',
                       child: Text('Dr.'),
                     ),],),
                  // DropDownInput(hint : 'Title *'),
                  Input(title: 'First Name*',),
                  Input(title: 'last Name',),
                  Input(title: 'account name',),
                  // DropDownInput(hint : 'designation'),
                  CustomDropDown(labelText : 'designation',items: [ DropdownMenuItem(
                    value: 'Item 1',
                    child: Text('Administration'),
                  ),
                    DropdownMenuItem(
                      value: 'Item 2',
                      child: Text('Department'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 3',
                      child: Text('Finance'),
                    ),DropdownMenuItem(
                      value: 'Item 4',
                      child: Text('Human Resources'),
                    ),DropdownMenuItem(
                      value: 'Item 5',
                      child: Text('Information Technology'),
                    ),DropdownMenuItem(
                      value: 'Item 6',
                      child: Text('Logistics'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 7',
                      child: Text('Maintainance'),
                    ),DropdownMenuItem(
                      value: 'Item 8',
                      child: Text('Accountant'),
                    ),DropdownMenuItem(
                      value: 'Item 9',
                      child: Text('Administrative Assistant'),
                    ),DropdownMenuItem(
                      value: 'Item 10',
                      child: Text('Advocate'),
                    ),DropdownMenuItem(
                      value: 'Item 11',
                      child: Text('Business Analyst 1'),
                    ),DropdownMenuItem(
                      value: 'Item 12',
                      child: Text('Business Development Manager'),
                    ),DropdownMenuItem(
                      value: 'Item 13',
                      child: Text('Chief Executive Officer (CEO)'),
                    ),DropdownMenuItem(
                      value: 'Item 14',
                      child: Text('Chief Financial Officer (CFO)'),
                    ),],),
                  // DropDownInput(hint : 'Mobile Number'),
                  Input(title: 'Mobile Number',),
                  Input(title: 'Alternate Mobile Number',),
                  Input(title: 'Work Phone',),
                  Input(title: 'Residence Phone',),
                  Input(title: 'Email Address',),
                  Input(title: 'Alternate Email Address',),
                  Input(title: 'Address Line1',),
                  Input(title: 'Address Line2',),
                  Input(title: 'Address Line3',),

                  // Input(hint: 'city',),
                  // DropDownInput(hint:  'state',),
                  // DropDownInput(hint: 'country',),
                  // Input(title: 'pincode',),
                  // Input(title: 'GPS Coordinate',),







                ],
              ),
            ),


        ]
    );
  }

}



