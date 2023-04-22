import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';

import '../../../../../../../utils/color.dart';
import '../../../../../../../utils/popups/date_picker.dart';
import '../../../contacts/widgets/CustomAppBar.dart';
import '../../../contacts/widgets/ToggleButtonRow.dart';

class AddCompetition extends StatelessWidget {
  const AddCompetition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: EdgeInsets.all(12.sp),
              child: Text("New Competition Acivity" , style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20.sp,
                  fontFamily: 'roboto_bold'
              ),),
            ),

            Column(

              children: [
                Input(title: "Account Name"),

                Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Input(title: "Competition Name")),
      Container(

        padding: EdgeInsets.only(left: 16.w , right: 16.w, top: 15.h),
        child: TextFormField(

          decoration: InputDecoration(

            labelText: "Competition Activity",
            hintText: "Competition Activity",
            hintStyle: TextStyle(color: Color(0xff8F9BB3),fontSize: 14.sp,fontWeight: FontWeight.w400,fontFamily: "roboto_regular"),
            border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(8.sp),
              borderSide: BorderSide(
                color: Color(0xffB4C6D4),
              ),
            ),

          ),
        ),
      ),

              ],
            )




           , ToggleButtonRow(title: 'Is Active',),
            Container(
              margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 45.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(child: Text("Cancel" , style:   TextStyle(color: Colors.white),)),
                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),
                      color: Color(0xff8199AC),
                    ),
                  ),
                  Container(
                    child: Center(child: Text("Save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold"),)),
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
      ),
    );
  }
}
