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
import '../../../widgets/activities_row.dart';
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


