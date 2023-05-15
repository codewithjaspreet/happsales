import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/activities/views/activity_view.dart';

import '../../../../../utils/color.dart';
import '../../contacts/widgets/HDivider.dart';

class OpportunityListRow extends StatefulWidget {
  const OpportunityListRow({super.key, required this.date, required this.time, required this.detail});

  final String date;
  final String time;
  final String detail;

  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<OpportunityListRow> {
  bool _isOpen = true;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });


  }


  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [

      Container(
        margin: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
        child: GestureDetector(
          onTap: () {
        _toggleDropdown();
      },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.date,
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: "roboto_medium",
                        fontSize: 14.sp),
                  ),
                ],
              ),
              GestureDetector(
                  onTap: _toggleDropdown,
                  child: Image.asset(_isOpen
                      ? "assets/contacts/back.png"
                      : "assets/contacts/up.png")),
            ],
          ),
        ),
      ),
      if (_isOpen)
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(

              horizontal: 10.w,
              vertical: 10.h
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
          
                Container(
                    // margin: EdgeInsets.all(30.sp),
          
          
          
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
          
                    Container(
                      child: Text(widget.time,
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: "roboto_medium",
                              fontSize: 14.sp)),
                    ),

                    SizedBox(width: 10.w,),
          
                    GestureDetector(
                      onTap: () {
                        Get.to(ActivityDetails());
                      },
                      child: Container(
                              
                        width: 230.w,
                        height: 55.h,
                              
                        decoration:BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.sp)
                        
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8.sp),
                          child: Center(child: Text(widget.detail ,
                          
                          style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: "roboto_medium",
                                  fontSize: 14.sp)
                          
                          ),),
                        ),
                      ),
                    )
                  ]),
                ),

                Hdivider()
               
              ],
            ),
          ),
        ),
    ]);
  }
}
