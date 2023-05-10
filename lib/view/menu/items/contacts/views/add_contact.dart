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
  const AddContact({super.key});

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
            const AddContactDetails(),
            Hdivider(),
            const MoreAddDetails(),
            Hdivider(),
            Container(
              margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),
                      color: const Color(0xff8199AC),
                    ),
                    child: Center(child: Text("Cancel" , style:   TextStyle(color: Colors.white,fontSize: 18.sp),)),
                  ),
                  Container(
                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),

                      shape: BoxShape.rectangle,
                      color: AppColors.primaryColor,
                    ),
                    child: Center(child: Text("Save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold"
                    ,fontSize: 18.sp
                    ),)),
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









