import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/color.dart';
import '../../../../../../../utils/popups/date_picker.dart';
import '../../../../contacts/widgets/CustomAppBar.dart';
import '../../../../contacts/widgets/HelperRow.dart';
import '../../../../contacts/widgets/InputOne.dart';
import '../../../../contacts/widgets/ToggleButtonRow.dart';

class AddBuying extends StatelessWidget {
  const AddBuying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: CustomAppBar(context),
      body: Column(
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

            padding: EdgeInsets.all(12.sp),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Business Plan",
                hintStyle: TextStyle(
                  color: Color(0xff8F9BB3),
                  fontSize: 14.sp,
                  fontFamily: 'roboto_regular'
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 70.h),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 12.sp),

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
    );
  }
}
