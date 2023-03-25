import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/DropDownInput.dart';

import '../../../../../utils/color.dart';
import '../../../../../viewmodels/contact_view_model.dart';
import '../widgets/AmiRow.dart';
import '../widgets/CustomAppBar.dart';

class EditContact extends StatelessWidget {
   // EditContact({Key? key, required this.Id}) : super(key: key);


  ContactViewModel contactViewModel = Get.put(ContactViewModel());
  // final int Id;
  @override
  Widget build(BuildContext context) {

    // Contact? contact = contactViewModel.getUserById(Id);

    return Scaffold(

      appBar: CustomAppBar(context, ),
      body: Column(
        children: [
          AmiHeaderRow(title: 'Edit Contact',),
          DetailRow(),
        ],
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
                    'Contact Details',
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
                        child: Icon(
                            _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down)),

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

                        DropDownInput(hint: 'Title *'),

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
