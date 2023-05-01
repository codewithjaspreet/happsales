import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';

import '../../../../../../../utils/color.dart';
import '../../../../../../../utils/popups/date_picker.dart';
import '../../../contacts/widgets/CustomAppBar.dart';
import '../../../contacts/widgets/ToggleButtonRow.dart';
import '../widgets/new_process_add_feild.dart';

class AddBusiness extends StatelessWidget {
  const AddBusiness({Key? key}) : super(key: key);

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
              child: Text("New Business Plan" , style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20.sp,
                  fontFamily: 'roboto_bold'
              ),),
            ),


Input(title: 'Account Name',),
            SizedBox(
              height: 10.h,
            ),

            NewProcessAddFeild(title: 'Business Plan',),

            DatePickerFeild(labelText: 'Customer Target Date'),

            ToggleButtonRow(title: 'Is Active',isAlreadyActive  :true),
            Container(
              margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 45.h),
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
                    child: Center(child: Text("Save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold",fontSize: 18.sp),)),
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
