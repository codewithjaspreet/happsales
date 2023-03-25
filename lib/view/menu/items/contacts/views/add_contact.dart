import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/AlertBox.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/BusinessCard.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/DropDown.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/DropDownInput.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputTwo.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/alert.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/common_navbar.dart';
import 'package:happsales_crm/view/menu/views/menu.dart';

import '../../../../../utils/color.dart';
import '../widgets/AmiRow.dart';
class AddContact extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),

      body:  SingleChildScrollView(
        child: Column(
          children: [
            AmiHeaderRow(title: 'Add Contact',),

            GestureDetector(
                onTap: () {
                  showDialogs(context);
                },
                child: BusinessCard()),

            Hdivider(),
            MyRow()


          ],
        ),
      )
    );
  }




}










class MyRow extends StatefulWidget {
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<MyRow> {
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
                  child: Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down)),
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
          )
      ]
    );
  }

}





