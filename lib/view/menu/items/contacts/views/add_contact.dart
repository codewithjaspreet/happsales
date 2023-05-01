import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/BusinessCard.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/alert.dart';
import '../../../../../utils/color.dart';
import '../widgets/AddContactDetails.dart';
import '../widgets/AmiRow.dart';
import '../widgets/MoreAddDetails.dart';
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
                child: const BusinessCard()),
            Hdivider(),
            AddContactDetails(),
            Hdivider(),
            MoreAddDetails(),
            Hdivider(),
            Container(
              margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(child: Text("Cancel" , style:   TextStyle(color: Colors.white,fontSize: 18.sp),)),
                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),
                      color: Color(0xff8199AC),
                    ),
                  ),
                  Container(
                    child: Center(child: Text("Save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold"
                    ,fontSize: 18.sp
                    ),)),
                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),

                      shape: BoxShape.rectangle,
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              ),
            )





          ],
        ),
      )
    );
  }
}









