import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/popups/custom_dropdown.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/ToggleButtonRow.dart';

import '../../../../../../utils/color.dart';
import '../../../contacts/widgets/HDivider.dart';
import '../../../contacts/widgets/InputOne.dart';
import '../BuyingProcess/widgets/buy_sec_row.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.all(12.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.w),
                    child: Text(
                      'Add Address',
                      style: TextStyle(
                          fontFamily: 'roboto_medium',
                          fontSize: 20.sp,
                          color: AppColors.primaryColor),
                    ),
                  ),



                ],
              ),
            ),

            Column(
              children: [
                Input(
                  title: 'Account Name',
                ),
                Input(

                  title: 'Contact Name',
                ),
                CustomDropDown(items: [], labelText: 'Address Type',),
                Container(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // locationController.getCurrentLocation();
                        },
                        child: Icon(
                          Icons.gps_fixed,
                          color: Color(0xff8F9BB3),
                        ),
                      ),
                      labelText: 'Address Line 1',
                      hintText: 'Address Line 1',
                      hintStyle: TextStyle(
                          color: Color(0xff8F9BB3),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "roboto_regular"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                        borderSide: BorderSide(
                          color: Color(0xffB4C6D4),
                        ),
                      ),
                    ),
                  ),
                ),
                Input(
                  title: 'Address Line2',
                ),
                Input(
                  title: 'Address Line3',
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xff8F9BB3),
                      ),
                      labelText: 'City',
                      hintText: 'City',
                      hintStyle: TextStyle(
                          color: Color(0xff8F9BB3),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "roboto_regular"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                        borderSide: BorderSide(
                          color: Color(0xffB4C6D4),
                        ),
                      ),
                    ),
                  ),
                ),
                Input(
                  title: 'State',
                ),
                CustomDropDown(items: [
                  DropdownMenuItem(
                    value: 'Item 1',
                    child: Text('India'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 2',
                    child: Text('USA'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 3',
                    child: Text('Australia'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 4',
                    child: Text('Canada'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 5',
                    child: Text('UK'),
                  ),
                ], labelText: 'Country'),
                Input(
                  title: 'PinCode',
                ),
                Input(
                  title: 'GPS Coordinates',
                ),
                ToggleButtonRow(title: 'Is Active',isAlreadyActive : true,),


              ],
            ),

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
          ]


        ),
      ),
    );
  }
}
