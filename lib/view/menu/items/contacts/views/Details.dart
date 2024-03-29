import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/FourthTypeDetailing.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/MoreDetail.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/SecondTypeDetailing.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/ThirdTypeDetailing.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';

import '../../../../../models/contact.dart';
import '../../../../../viewmodels/contact_view_model.dart';
import 'edit_contact.dart';

class ContactDetails extends StatelessWidget {
  ContactDetails({Key? key, required this.Id}) : super(key: key);


  ContactViewModel contactViewModel = Get.put(ContactViewModel());
  final int Id;

  @override
  Widget build(BuildContext context) {

    Contact? contact = contactViewModel.getUserById(Id);
    print(contact!.firstName);
    return Scaffold(
        appBar: CustomAppBar(context),
        body: Stack(
          children:[ SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserDetailCard( title : contact.firstName , designation: contact.designation ),
                Hdivider(),
                DetailRow(contact : contact),
                Hdivider(),
                MoreDetail(contact : contact),
                SizedBox(height: 12.h,),
                Hdivider(),
        
              SecondTypeDetailing(title: 'Is Active', subTitle: contact.isPrimaryContact.toString(),),
        
        
                ThirdTypeDetailing(title1: 'Created By', subTitle1: contact.createdBy.toString(), title2: 'Modified By', subTitle2: 'Suvarna Traders'),
                SizedBox(height: 12.h,),
        
                ThirdTypeDetailing(title1: 'Created On', subTitle1: contact.createdOn.toString(), title2: 'Modified On', subTitle2: '29 Dec 2021'),
        
              ],
            ),
          ),
          bottomDetailsSheet()
          ]
        ));
  }

  Column UserDetailCard({String? title , String? designation }) {



    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
          width: 337.w,
          height: 216.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffAA80F9),
                  Color(0xff6165D7),
                ],
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.h, left: 20.w),
                child: Row(
                  children: [
                    Container(
                      width: 63.w,
                      height: 63.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 2.w),
                        child: Center(
                          child: Text(
                            "${title![0]}${title.split(' ')[1][0]}",
                            // firstName![0]+ lastName![0],
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 44.sp),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "Suvarna traders",
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.h, left: 25.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(

                          title,

                          // name of the user getting accessed
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontFamily: "roboto_bold"),
                        ),
                      ),
                      Container(
                        child: Text(
                          // "Maintenance Manager",
                          designation!,
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                      ),
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.h, left: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(

                        // phNo! ?? "",
                        "99999 12345",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: "roboto_bold"),
                      ),
                    ),
                    Container(
                      child: Text(
                        // email!,
                        "radha.krishna@SuvarnaTraders.com",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: "roboto_bold"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DetailRow extends StatefulWidget {

  const DetailRow({Key? key, required this.contact}) : super(key: key);
  // ContactViewModel contactViewModel = Get.put(ContactViewModel());
  final  Contact contact;
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<DetailRow> {
  bool _isOpen = true;
  bool seeMore = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }


  void _toggleSeeMore() {
    setState(() {
      seeMore = !seeMore;
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
                              title: 'Contact Name',
                              // subTitle: widget.contactViewModel.contactList[0].contactName,
                              subTitle: widget.contact.contactName!.toString(),
                            ),
                            SecondTypeDetailing(
                              title: 'Account Name',
                              subTitle: widget.contact.accountName!.toString(),
                            ),
                            // ThirdTypeDetailing(),
                            ThirdTypeDetailing(
                              title1: 'Department',
                              subTitle1: widget.contact.departmentName!.toString(),
                              title2: 'Designation',
                              subTitle2: widget.contact.designation!.toString(),
                            ),

                            SizedBox(
                              height: 5.h,
                            ),


                            FourthTypeDetailing(
                              title1: 'Mobile number',
                              subTitle1: widget.contact.mobileNumber!.toString(),
                              title2: 'Mobile number',
                              subTitle2: widget.contact.alternateMobileNumber!.toString(),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            FourthTypeDetailing(
                              title1: 'Work Phone',
                              subTitle1:  widget.contact.workPhone!.toString().isEmpty ? "-" : widget.contact.workPhone!.toString(),
                              title2: 'Residence Phone',
                              subTitle2:  widget.contact.residencePhone!.toString().isEmpty ? "-" : widget.contact.residencePhone!.toString(),
                            ),

                           SecondTypeDetailing(title: 'Email Address', subTitle: widget.contact.email!.toString().isEmpty ? "-" : widget.contact.email!.toString() ),
                            SecondTypeDetailing(title: 'Alt. Email Address', subTitle: widget.contact.alternateEmail!.toString().isEmpty ? "-" : widget.contact.alternateEmail!.toString() ),


                            ThirdTypeDetailing(
                                title1: 'Address',
                                subTitle1:
                                widget.contact.addressLine1!.toString().isEmpty ? "-" : widget.contact.addressLine1!.toString(),
                                title2: 'GPS Coordinate',
                                subTitle2:   widget.contact.gPSCoordinates!.toString().isEmpty ? "-" : widget.contact.gPSCoordinates!.toString(),),


                        seeMore ? const SizedBox.shrink() :       GestureDetector(
                              onTap: (){
                                _toggleSeeMore();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10.h, left: 16.w),
                                width: 125.w,
                                height:48.h,
                                decoration: BoxDecoration(
                                  borderRadius:  BorderRadius.circular(26.sp),

                                  shape: BoxShape.rectangle,
                                  color: AppColors.primaryColor,
                                ),
                                child: Center(child: Text("See More" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold",fontSize: 16.sp),)),
                              ),
                            ),

                              if(seeMore)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SecondTypeDetailing(title: 'Reporting To', subTitle:  widget.contact.reportingManager!.toString().isEmpty ? "-" : widget.contact.reportingManager!.toString(),),
                                    Detaling(title: 'LinkedIn', subTitle:widget.contact.linkedIn!.toString().isEmpty ? "-" : widget.contact.linkedIn!.toString(),),
                                    ThirdTypeDetailing(title1: 'DoB', subTitle1: widget.contact.dateOfBirth!.toString().isEmpty ? "-" : widget.contact.dateOfBirth!.toString(), title2: 'Reminder', subTitle2: 'no'),
                                    SecondTypeDetailing(title: 'Contact Alignment', subTitle:widget.contact.contactAlignmentID!.toString().isEmpty ? "-" : widget.contact.contactAlignmentID!.toString(),),
                                    SecondTypeDetailing(title: 'Roles & Responsibilities', subTitle:widget.contact.rolesAndResponsibilities!.toString().isEmpty ? "-" : widget.contact.rolesAndResponsibilities!.toString(),),
                                    SecondTypeDetailing(title: 'Past Accounts', subTitle: widget.contact.pastAccounts!.toString().isEmpty ? "-" : widget.contact.pastAccounts!.toString(),),
                                    SecondTypeDetailing(title: 'Past Designations', subTitle: widget.contact.pastDesignations!.toString().isEmpty ? "-" : widget.contact.pastDesignations!.toString(),),
                                    SecondTypeDetailing(title: 'Reference History', subTitle: widget.contact.referenceHistory.toString().isNull ? "-" : widget.contact.referenceHistory.toString()),
                                    SecondTypeDetailing(title: 'Tags', subTitle: widget.contact.tags.toString().isEmpty ? "-" : widget.contact.tags.toString(),),
                                    SecondTypeDetailing(title: 'Remarks', subTitle: widget.contact.remarks.toString().isEmpty ? "-" : widget.contact.remarks.toString(),),
                                    SecondTypeDetailing(title: 'Is Primary Contact', subTitle:  widget.contact.isPrimaryContact.toString().isEmpty ? "-" : widget.contact.isPrimaryContact.toString(),),
                                    !seeMore ? const SizedBox.shrink() :       GestureDetector(
                                      onTap: (){
                                        _toggleSeeMore();
                                      },
                                      child:  Container(
                                        margin: EdgeInsets.only(top: 10.h, left: 30.w),
                                        width: 125.w,
                                        height:48.h,
                                        decoration: BoxDecoration(
                                          borderRadius:  BorderRadius.circular(26.sp),

                                          shape: BoxShape.rectangle,
                                          color: AppColors.primaryColor,
                                        ),
                                        child: Center(child: Text("See Less" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold",fontSize: 16.sp),)),
                                      ),
                                    ),
                                  ],
                                )

],
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
class Detaling extends StatelessWidget {
  const Detaling({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20.sp),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff00A6D6),


                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),

          ],
        )
      ],
    );
  }
}
