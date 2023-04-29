import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../models/contact.dart';
import '../../../../../utils/color.dart';

class MoreDetail extends StatefulWidget {


  final Contact contact;
  const MoreDetail({ required this.contact});

  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<MoreDetail> {
  bool _isOpen = true;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
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
                      'Additional Section',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: "roboto_medium",
                          fontSize: 14.sp),
                    ),
                  ],
                ),
                Row(

                  children: [

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

                          DetailItems(),





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


class DetailItems extends StatelessWidget {
  const DetailItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IndividualItem(imageUrl: 'assets/contacts/activity.png', title: 'Activity',),
          IndividualItem(imageUrl: 'assets/contacts/oppor.png', title: 'Opportunity',),
          IndividualItem(imageUrl: 'assets/contacts/notes.png', title: 'Notes',),
        ],
      ),

    );

  }
}
class IndividualItem extends StatelessWidget {
  const IndividualItem({Key? key, required this.imageUrl, required this.title}) : super(key: key);

  final String imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: Color(0xffF5F6F9),

            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(imageUrl),
                Text(

                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: "roboto_bold",
                    color: Color(0xff00A6D6),
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
        ),
        Positioned(
          top: 10.h,
          left: 70.w,
          child: Container(
            child: Center(
              child: Text(
                '2',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: "roboto_bold",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Color(0xff00A6D6),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
