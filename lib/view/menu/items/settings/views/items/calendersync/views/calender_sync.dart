import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/ToggleButtonRow.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';

import '../../../../../../../../utils/color.dart';

class CalenderSync extends StatelessWidget {
  const CalenderSync({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Stack(children: [

        Column(
          children: [
            Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 4.w),
            child: Text('Calender Sync' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),)),
        ],
      ),
    )
    ,
        ToggleButtonRow(title: 'Enable Apple Calender Sync', isAlreadyActive: false)
,Container(
            margin: EdgeInsets.only(left: 18.w),
            child: Text('By enabling this feature your activity will sync with apple calender and vice versa' , style: TextStyle( fontSize: 12.sp,color: AppColors.primaryColor),)),
    
          ],
        ),

        bottomDetailsSheet()
      ]),
    );
  }
}