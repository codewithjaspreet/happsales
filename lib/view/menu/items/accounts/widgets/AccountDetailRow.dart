
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../models/contact.dart';
import '../../../../../utils/color.dart';
import '../../contacts/views/Details.dart';
import '../../contacts/views/edit_contact.dart';
import '../../contacts/widgets/FifthTypeDetailing.dart';
import '../../contacts/widgets/FourthTypeDetailing.dart';
import '../../contacts/widgets/SecondTypeDetailing.dart';
import '../../contacts/widgets/ThirdTypeDetailing.dart';

class AccountDetailRow extends StatefulWidget {

  const AccountDetailRow({Key? key, required this.contact}) : super(key: key);
  // ContactViewModel contactViewModel = Get.put(ContactViewModel());
  final  Contact contact;
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<AccountDetailRow> {
  bool _isOpen = true;

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
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: GestureDetector(
                          onTap: (){
                            Get.to(() => EditContact());
                          },
                          child: Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: Image.asset("assets/contacts/edit.png"),
                            ),
                          )),
                    ),
                    GestureDetector(
                        onTap: _toggleDropdown,
                        child:Image.asset(
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
                        Detaling(
                          title: 'contact name',
                          // subTitle: widget.contactViewModel.contactList[0].contactName,
                          subTitle: widget.contact.contactName!.toString(),
                        ),
                        SecondTypeDetailing(
                          title: 'Account name',
                          subTitle: widget.contact.accountName!.toString(),
                        ),
                        // ThirdTypeDetailing(),
                        ThirdTypeDetailing(
                          title1: 'Department',
                          subTitle1: widget.contact.departmentName!.toString(),
                          title2: 'Designation',
                          subTitle2: widget.contact.designation!.toString(),
                        ),

                        FourthTypeDetailing(
                          title1: 'Mobile number',
                          subTitle1: widget.contact.mobileNumber!.toString(),
                          title2: 'Mobile number',
                          subTitle2: widget.contact.alternateMobileNumber!.toString(),
                        ),
                        FourthTypeDetailing(
                          title1: 'Work Phone',
                          subTitle1: widget.contact.workPhone!.toString(),
                          title2: 'Residence Phone',
                          subTitle2: widget.contact.residencePhone!.toString(),
                        ),

                        FifthTypeDetailing(
                          title: 'Email Address',
                          subTitle: widget.contact.email!.toString(),
                          // subTitle: controller.contactList[0].email,
                        ),

                        FifthTypeDetailing(
                          title: 'Alt. Email Address',
                          subTitle:   widget.contact.alternateEmail!.toString(),
                        ),

                        ThirdTypeDetailing(
                            title1: 'Address',
                            subTitle1:
                            widget.contact.addressLine1!.toString(),
                            title2: 'GPS Coordinate',
                            subTitle2: widget.contact.gPSCoordinates!.toString()),

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
