import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/contacts/add_contact.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/opportunity/views/opportunity_listing.dart';

import '../../../../../../../../utils/color.dart';
import '../../activity_view.dart';

class ActivityOverDue extends StatelessWidget {
  const ActivityOverDue({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(children: [
       Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(
      
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Overdue Activities' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
          Row(
            children: [
      
              GestureDetector(
                onTap: (){
                  Get.to(AddContact());
                },
                child: Container(
                  margin:  EdgeInsets.only(left: 22.w),
                  width: 25.w,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
      
                  ),
                  child:  Center(
                    child: Image.asset('assets/activities/calender.png'),
                  ),
                ),
              ),
              
              GestureDetector(
                onTap: (){
                  Get.to(AddContact());
                },
                child: Container(
                  margin:  EdgeInsets.only(left: 20.w),
                  width: 25.w,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff171A63),
      
                  ),
                  child: const Center(
                    child: Icon(Icons.add ,color: Colors.white,),
                  ),
                ),
              ),
      
              
            ],
          ),
      
      
      
        ],
      ),
      
        ),
      
      
      Image.asset('assets/activities/banner.png'),
      buildOpportunityList(),
      
       
      
      
      
      ]),
    );
  }
}

buildOpportunityList() {
  return  Expanded(
      child: ListView.builder(
        // padding: EdgeInsets.all(12.sp),
        itemCount:6,
        itemBuilder: (context, index) {
          return OpportunityListRow(time: '08:03 AM', detail: 'Meeting[check 31 aug]On 23-Oct-2021 At 4:33 Pm', date:'24 Oct 2021');
        },
      ));
}


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
    return GestureDetector(
      onTap: () {
        _toggleDropdown();
      },
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
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
            
                      Container(
            
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
                      )
                    ]),
                  ),

                  Hdivider()
                 
                ],
              ),
            ),
          ),
      ]),
    );
  }
}
