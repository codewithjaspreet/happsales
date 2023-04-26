import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/models/account_model.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/DropDownInput.dart';

import '../../../../../utils/color.dart';
import '../../../../../viewmodels/contact_view_model.dart';
import '../../../../utils/popups/custom_dropdown.dart';
import '../contacts/widgets/AmiRow.dart';
import '../contacts/widgets/CustomAppBar.dart';
import '../contacts/widgets/InputOne.dart';

class EditAccount extends StatelessWidget {


  // final int Id;

  @override
  Widget build(BuildContext context) {

    // Contact? contact = contactViewModel.getUserById(Id);

    return Scaffold(

      appBar: CustomAppBar(context, ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AmiHeaderRow(title: 'Edit Accounts',),
            DetailRow(),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatefulWidget {

  // DetailRow({Key? key, required this.contact}) : super(key: key);
  // ContactViewModel contactViewModel = Get.put(ContactViewModel());
  // final  Contact contact;
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<DetailRow> {
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
        onTap: (){
          _toggleDropdown();
        },
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
                      'Account Details',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: "roboto_medium",
                          fontSize: 14.sp),
                    ),
                  ],
                ),
                Container(

                  child: Row(

                    children: [

                      GestureDetector(
                          onTap: _toggleDropdown,
                          child: Image.asset(
                              _isOpen ? "assets/contacts/up.png" : "assets/contacts/back.png")),

                    ],
                  ),
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

                         Input(title: 'Account Name'),
                          Input(title: 'Location *'),
                          Input(title: 'Segment'),
                          Input(title: 'Status'),
                          Input(title: 'Type '),
                          Input(title: 'Industry'),
                          Input(title: 'Work Phone'),
                          Input(title: 'Website '),
                          Input(title: 'Number of Employees'),
                          Input(title: 'Currency'),


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
