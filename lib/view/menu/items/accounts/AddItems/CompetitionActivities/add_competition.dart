import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              child: Text("New Buying Process" , style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20.sp,
                  fontFamily: 'roboto_bold'
              ),),
            ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: TextFormField(


                decoration: InputDecoration(
                  // hintText: "Buying Process Name",

                  contentPadding: EdgeInsets.symmetric(vertical: 70.h),
                  // labelText: "Buying Process Name",
                  labelStyle: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                      fontFamily: 'roboto_bold'
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.sp
                      )
                  ),


                ),
              ),
            ),



            DatePickerFeild(labelText: 'Customer Target Date',),
            ToggleButtonRow(title: 'Is Active',),
            Container(
              margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 45.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(child: Text("cancel" , style:   TextStyle(color: Colors.white),)),
                    width: 125.w,
                    height:48.h,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(26.sp),
                      color: Color(0xff8199AC),
                    ),
                  ),
                  Container(
                    child: Center(child: Text("save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold"),)),
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
